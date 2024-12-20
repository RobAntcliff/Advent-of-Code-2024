def part_1
  map = File.read(File.join(__dir__, "day_20_input.txt")).split("\n")
  start = map.each_with_index.find { |line, index| line.include?("S") }
  start = [start[1], start[0].index("S")] if start
  directions = [[1,0], [-1,0], [0,1], [0,-1]]
  path = [start]

  end_found = false

  current = start
  previous = nil

  while !end_found
    directions.each do |direction|
      new_position = [current[0] + direction[0], current[1] + direction[1]]
      if map[new_position[0]][new_position[1]] == "E"
        path << new_position
        end_found = true
        break
      end
      if map[new_position[0]][new_position[1]] == "." && new_position != previous
        path << new_position
        previous = current
        current = new_position
      end
    end
  end

  track_length = path.length
  path_hash = {}
  path.each_with_index do |position, index|
    path_hash[position] = index
  end
  time_to_be_saved = 100
  count = 0

  (track_length).times do |step|
    current = path[step - 1]
    directions.each do |direction|
      new_position = [current[0] + direction[0], current[1] + direction[1]]
      if new_position[0].between?(0, map.length-1) && new_position[1].between?(0, map[0].length-1) && map[new_position[0]][new_position[1]] == "#"
        potential_speed_spot = [new_position[0] + direction[0], new_position[1] + direction[1]]
        if path_hash.key?(potential_speed_spot) && (map[potential_speed_spot[0]][potential_speed_spot[1]] == "." || map[potential_speed_spot[0]][potential_speed_spot[1]] == "E")
          if(path_hash[potential_speed_spot] - path_hash[current] >= time_to_be_saved + 2)
            count += 1
          end
        end
      end
    end
  end

  puts count
end

def part_2
  map = File.read(File.join(__dir__, "test_input.txt")).split("\n")
  start = map.each_with_index.find { |line, index| line.include?("S") }
  start = [start[1], start[0].index("S")] if start
  directions = [[1,0], [-1,0], [0,1], [0,-1]]
  path = [start]

  end_found = false

  current = start
  previous = nil

  while !end_found
    directions.each do |direction|
      new_position = [current[0] + direction[0], current[1] + direction[1]]
      if map[new_position[0]][new_position[1]] == "E"
        path << new_position
        end_found = true
        break
      end
      if map[new_position[0]][new_position[1]] == "." && new_position != previous
        path << new_position
        previous = current
        current = new_position
      end
    end
  end

  track_length = path.length
  path_hash = {}
  path.each_with_index do |position, index|
    path_hash[position] = index
  end
  time_to_be_saved = 50
  count = 0

  (track_length).times do |step|
    current = path[step - 1]
    possible_positions = find_possible_positions(current, 20)
    possible_positions.each do |position|
      if position[0].between?(0, map.length-1) && position[1].between?(0, map[0].length-1) && map[position[0]][position[1]] == "."
        if path_hash.key?(position) && (map[position[0]][position[1]] == "." || map[position[0]][position[1]] == "E")
          if(path_hash[position] - path_hash[current] >= time_to_be_saved - position[2])
            count += 1
          end
        end
      end
    end
  end

  puts count
end

def find_possible_positions(position, max_moves)
  positions = Set.new
  positions.add([position[0], position[1], 0])  # [x, y, distance]
  
  max_moves.times do |move_number|
    current_positions = positions.dup
    current_positions.each do |x, y, dist|
      # Only process positions from the previous round
      next unless dist == move_number
      
      # Add all possible moves from current position
      [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].each do |new_x, new_y|
        # Only add if we haven't found a shorter path to this point
        new_pos = [new_x, new_y, dist + 1]
        positions.add(new_pos) unless positions.any? { |px, py, _| px == new_x && py == new_y }
      end
    end
  end
  
  positions
end

part_2


