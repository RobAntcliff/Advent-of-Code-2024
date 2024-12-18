def part_1
  coordinates = []
  File.read(File.join(__dir__, "day_18_input.txt")).split("\n").each do |line|
    coordinates << line.split(",").map(&:to_i)
  end

  coords_set = Set.new
  coordinates.each.with_index do |coord, index|
    if(index == 1024)
      break
    end
    coords_set.add(coord)
  end

  result = get_shortest_distance([0, 0], [70, 70],coords_set)
  puts result
end

def part_2
  coordinates = []
  File.read(File.join(__dir__, "day_18_input.txt")).split("\n").each do |line|
    coordinates << line.split(",").map(&:to_i)
  end

  coords_set = Set.new
  coordinates.each.with_index do |coord, index|
    if(index == 1024)
      break
    end
    coords_set.add(coord)
  end

  result = get_shortest_distance([0, 0], [70, 70],coords_set)
  puts result
end

def get_shortest_distance(starting_point, ending_point, coords_set)

  steps = [[0,1], [0,-1], [1,0], [-1,0]]
  distance = 0

  queue = [starting_point, distance]
  visited = Set.new
  visited.add(starting_point)

  while !queue.empty?
    current_point, current_distance = queue.shift
    steps.each do |step|
      new_point = [current_point[0] + step[0], current_point[1] + step[1]]
      if new_point == ending_point
        return current_distance + 1
      end
      # bounds checking
      if new_point[0] < 0 || new_point[0] > ending_point[0] || new_point[1] < 0 || new_point[1] > ending_point[1]
        next
      end
      if !visited.include?(new_point) && !coords_set.include?(new_point)
        visited.add(new_point)
        queue.push([new_point, current_distance + 1])
      end
    end
  end
  return nil
end

part_1
