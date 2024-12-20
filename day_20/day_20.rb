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

part_1


