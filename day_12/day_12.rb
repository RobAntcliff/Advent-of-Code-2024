def part_1
    input = File.read("test_input.txt").split("\n").map { |line| line.chars }
    
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
    input = File.read("day_12_input.txt").split("\n").map { |line| line.chars }
    
    total = 0
    already_visited = Set.new
    input.each_with_index do |row, row_index|
        row.each_with_index do |element, col_index|
            area, sides = valid_paths_from_position_sides(input, [row_index, col_index], already_visited. nil)
            total += sides * area
        end
    end
    puts "Total: #{total}"
end

def valid_paths_from_position(input, start_position, already_visited)
    unless already_visited.nil?
        return 0, 0 if already_visited.include?(start_position)
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
            returned_area, returned_perimeter = valid_paths_from_position(input, new_position, already_visited)
            area += returned_area
            perimeter += returned_perimeter
        end
    end
    return area, perimeter
end

def valid_paths_from_position_sides(input, start_position, already_visited, current_direction)
    unless already_visited.nil?
        return 0, 0 if already_visited.include?(start_position)
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

            unless current_direction == direction || current_direction == nil
                perimeter += 1
            end
        else
            returned_area, returned_perimeter = valid_paths_from_position_sides(input, new_position, already_visited, direction)
            area += returned_area
            perimeter += returned_perimeter
        end
    end
    return area, perimeter
end

part_1