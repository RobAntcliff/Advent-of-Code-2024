def setup
    input = File.read("day_10_input.txt").split("\n").map.with_index do |line, index|
        line.split('').map(&:to_i)
    end

    start_positions = input.map.with_index do |row, row_index|
        row.map.with_index do |element, col_index|
            [row_index, col_index] if element == 0
        end.compact
    end.flatten(1)

    return input, start_positions
end

def part_1
    part_2(false)
end

def part_2(part2 = true)
    input, start_positions = setup

    valid_paths = 0
    start_positions.each do |start_position|
        if part2
            valid_paths += valid_paths_from_position(input, start_position)
        else
            already_visited = Set.new
            valid_paths += valid_paths_from_position(input, start_position, already_visited)
        end
    end

    puts valid_paths
end


def valid_paths_from_position(input, start_position, already_visited = nil)
    unless already_visited.nil?
        return 0 if already_visited.include?(start_position)
        already_visited.add(start_position)
    end

    return 0 if start_position[0] < 0 || start_position[0] >= input.length ||
                start_position[1] < 0 || start_position[1] >= input[0].length

    if input[start_position[0]][start_position[1]] == 9
        return 1
    end

    valid_paths = 0
    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    directions.each do |direction|
        new_position = [start_position[0] + direction[0], start_position[1] + direction[1]]
        valid_paths += valid_paths_from_position(input, new_position, already_visited) if 
            new_position[0] >= 0 && new_position[0] < input.length && 
            new_position[1] >= 0 && new_position[1] < input[0].length && 
            input[new_position[0]][new_position[1]] == input[start_position[0]][start_position[1]] + 1
    end
    valid_paths
end

part_1
part_2