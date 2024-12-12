def part_1
    input = File.read("day_12_input.txt").split("\n").map { |line| line.chars }
    
    total = 0
    already_visited = Set.new
    input.each_with_index do |row, row_index|
        row.each_with_index do |element, col_index|
            area, perimeter = valid_paths_from_position(input, [row_index, col_index], already_visited)
            total += perimeter * area
        end
    end
    puts "Total: #{total}"
end

def part_2
    input = File.read(File.join(__dir__, "day_12_input.txt")).split("\n").map { |line| line.chars }
    
    total = 0
    already_visited = Set.new
    input.each_with_index do |row, row_index|
        row.each_with_index do |element, col_index|
            current_blocks_visited = Set.new
            area, edges = valid_paths_from_position(input, [row_index, col_index], already_visited, current_blocks_visited)
            sides = get_sides(current_blocks_visited)
            if(area != 0 || sides != 0)
                #puts "Area: #{area}, Sides: #{sides}"
                total += sides * area
            end
        end
    end
    puts "Total: #{total}"
end

def valid_paths_from_position(input, start_position, already_visited, current_blocks_visited = nil)
    unless already_visited.nil?
        return 0, 0 if already_visited.include?(start_position)
    end

    if current_blocks_visited
        current_blocks_visited.add(start_position)
    end

    already_visited.add(start_position)

    return 0, 0 if start_position[0] < 0 || start_position[0] >= input.length ||
                start_position[1] < 0 || start_position[1] >= input[0].length

    area = 1
    perimeter = 0

    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    directions.each do |direction|
        new_position = [start_position[0] + direction[0], start_position[1] + direction[1]]

        if new_position[0] < 0 || new_position[0] >= input.length || 
            new_position[1] < 0 || new_position[1] >= input[0].length ||
            input[new_position[0]][new_position[1]] != input[start_position[0]][start_position[1]]

            perimeter += 1
        else
            returned_area, returned_perimeter = valid_paths_from_position(input, new_position, already_visited, current_blocks_visited)
            area += returned_area
            perimeter += returned_perimeter
        end
    end
    return area, perimeter
end

DIRECTION_TO_RIGHT_SIDE = {
  [1, 0] => [0, -1],  # East -> South
  [0, -1] => [-1, 0], # South -> West
  [-1, 0] => [0, 1],  # West -> North
  [0, 1] => [1, 0]    # North -> East
}

DIRECTION_TO_LEFT_SIDE = {
  [1, 0] => [0, 1],  # East -> North
  [0, 1] => [-1, 0], # North -> West
  [-1, 0] => [0, -1], # West -> South
  [0, -1] => [1, 0]   # South -> East
}

def get_sides(blocks_visited)
    # puts "\nBlock visualization:"
    # print_blocks(blocks_visited)
    sides = 0

    block_map = {}

    blocks_visited.each do |block|
        block_map[block] = {
            [1, 0] => false,
            [-1, 0] => false,
            [0, 1] => false,
            [0, -1] => false
        }
    end
    
    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    direction = [1, 0]
    blocks_visited.each do |block|
        # Skip over the direction if it has already been checked for this block
        if(block_map[block][direction])
            # puts "Skipping #{block} #{direction} because it has already been checked"
            next
        else
            # Set that we've seen this direction for this block
            block_map[block][direction] = true
        end

        right_side_check = DIRECTION_TO_RIGHT_SIDE[direction]
        # If there's no block to the right side, we've found a side
        right_hand_block_to_check = [block[0] + right_side_check[0], block[1] + right_side_check[1]]
        blocks_and_directions_this_cycle = {}
        unless(blocks_visited.include?(right_hand_block_to_check))
            # We've found a side
            # Set that we've seen this direction for this block
            block_map[block][direction] = true
            #puts "Found a side for block #{block} in direction #{direction}"
            

            current_block = block
            current_direction = direction
            continue_down_forward_path = true
            
            # Follow the sides, keeping track of the turns
            while continue_down_forward_path
                blocks_and_directions_this_cycle[[current_block, current_direction]] = true
                # puts "\nCurrent position: #{current_block}, Current direction: #{current_direction}"
                # print_blocks(blocks_visited, current_block)
                # puts "sides: #{sides}"
                
                block_map[current_block][current_direction] = true
                # check if the block has a side in the direction
                right_side_check = DIRECTION_TO_RIGHT_SIDE[current_direction]
                right_side_to_check = [current_block[0] + right_side_check[0], current_block[1] + right_side_check[1]]
                # If the right side exists, we've found a turn
                if blocks_visited.include?(right_side_to_check)
                    current_direction = right_side_check
                    sides += 1
                end
                # Continue down the path if the block in the direction exists
                forward_direction_to_check = [current_block[0] + current_direction[0], current_block[1] + current_direction[1]]
                if blocks_visited.include?(forward_direction_to_check)
                    current_block = forward_direction_to_check
                else
                    count = 0
                    #turn anti-clockwise
                    while count < 4
                        current_direction = DIRECTION_TO_LEFT_SIDE[current_direction]
                        #puts "current direction: #{current_direction}"
                        sides += 1
                        count += 1
                        forward_direction_to_check = [current_block[0] + current_direction[0], current_block[1] + current_direction[1]]
                        if blocks_and_directions_this_cycle[[current_block, current_direction]]
                            continue_down_forward_path = false
                            break
                        end
                        blocks_and_directions_this_cycle[[current_block, current_direction]] = true
                        if blocks_visited.include?(forward_direction_to_check)
                            current_block = forward_direction_to_check
                            break
                        end
                    end
                end

                if blocks_and_directions_this_cycle[[current_block, current_direction]]
                    continue_down_forward_path = false
                end
            end

            #puts "End Total sides: #{sides}"
        else
            #puts "No side for block #{block} in direction #{direction}"
        end

        blocks_and_directions_this_cycle.each do |block_and_direction, _value|
            temp_block = block_and_direction[0]  # Get the block from the array
            temp_direction = block_and_direction[1]  # Get the direction from the array
            block_map[temp_block][temp_direction] = true
        end
    end

    sides
end

def print_blocks(blocks_visited, current_position = nil)
    return if blocks_visited.empty?
    
    # Find the boundaries
    min_row = blocks_visited.map { |b| b[0] }.min
    max_row = blocks_visited.map { |b| b[0] }.max
    min_col = blocks_visited.map { |b| b[1] }.min
    max_col = blocks_visited.map { |b| b[1] }.max
    
    # Print the grid
    (min_row..max_row).each do |row|
        (min_col..max_col).each do |col|
            if current_position && current_position == [row, col]
                print "X"  # Highlight current position
            elsif blocks_visited.include?([row, col])
                print "█"  # Regular visited blocks
            else
                print "·"  # Empty space
            end
        end
        puts  # new line after each row
    end
    puts  # extra line after the grid
end

# start_time = Time.now
# part_1
# puts "Part 1 took #{Time.now - start_time} seconds to run"

start_time = Time.now
part_2
puts "Part 2 took #{Time.now - start_time} seconds to run"
