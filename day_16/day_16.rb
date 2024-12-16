require 'set'

def part_1
  input = File.read(File.join(__dir__, "test_input.txt")).split("\n")
  start_coordinates = input.each_with_index.find { |line, index| line.include?('S') }
  start_coordinates = [start_coordinates[1], start_coordinates[0].index('S')] if start_coordinates
  end_coordinates = input.each_with_index.find { |line, index| line.include?('E') }
  end_coordinates = [end_coordinates[1], end_coordinates[0].index('E')] if end_coordinates
  shortest_cost = shortest_cost(end_coordinates, start_coordinates, input)
  puts shortest_cost
end

def shortest_cost(start_coordinates, end_coordinates, input)
  visited = Set.new
  # Queue will store [coordinates, direction, cost]
  queue = []
  
  # Initialize with all possible starting directions
  directions = {
    east: [1, 0],
    south: [0, 1],
    west: [-1, 0],
    north: [0, -1]
  }
  
  # Add initial position with all possible directions
  directions.each_key do |direction|
    queue.push([start_coordinates, direction, 0])
  end
  
  while !queue.empty?
    current_coordinates, current_direction, current_cost = queue.shift
    
    # Skip if we've been here before
    next if visited.include?([current_coordinates, current_direction])
    
    current = input[current_coordinates[1]][current_coordinates[0]]
    next if current == "#" || current == "\n"
    
    # Check if we reached the end
    if current == "E"
      puts "  Found end"
      return current_cost
    end
    
    visited.add([current_coordinates, current_direction])
    
    # Try all directions
    directions.each_pair do |new_direction, vector|
      new_coordinates = [
        current_coordinates[0] + vector[0],
        current_coordinates[1] + vector[1]
      ]
      
      # Calculate new cost based on whether we're changing direction
      new_cost = if new_direction == current_direction
                   current_cost + 1
                 else
                   current_cost + 1001
                 end
      
      queue.push([new_coordinates, new_direction, new_cost])
    end
    
    # Sort queue by cost to ensure we explore cheaper paths first
    queue.sort_by! { |_, _, cost| cost }
  end
  
  Float::INFINITY  # Return infinity if no path is found
end

part_1
