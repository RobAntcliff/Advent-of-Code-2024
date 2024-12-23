def part_1
    puts get_antipodal_points.count
end

def part_2
    puts get_antipodal_points(true).count
end

def get_antipodal_points(harmonics = false)
    antenna_dict = get_antenna_dict
    result = 0
    max_x = File.open("day_8_input.txt").first.chomp.length
    max_y = File.open("day_8_input.txt").count

    antipodal_points = Set.new
    antenna_dict.each do |char, positions|
        positions.each_with_index do |position, i|
            positions[i+1..-1].each_with_index do |position2|
                if harmonics
                    add_valid_antipodal_points(position, position2, max_x, max_y, antipodal_points, true)
                else
                    add_valid_antipodal_points(position, position2, max_x, max_y, antipodal_points)
                end
            end
        end
    end
    return antipodal_points
end

def get_antenna_dict
    antenna_dict = {}
    File.open("day_8_input.txt").each_with_index do |line, i|
        line.chomp.split("").each_with_index do |char, j|
            unless char == "." or char == "#"
                if antenna_dict.key?(char)
                    antenna_dict[char] << [i, j]
                else
                    antenna_dict[char] = [[i, j]]
                end
            end
        end
    end
    return antenna_dict
end

def distance(position1, position2)
    x1, y1 = position1
    x2, y2 = position2
    return (x2 - x1)**2 + (y2 - y1)**2
end

# def add_valid_antipodal_points(position1, position2, max_x, max_y, antipodal_points)
#     antinode1, antinode2 = get_antinodes(position1, position2)
#     if antinode1[0].between?(0, max_x - 1) && antinode1[1].between?(0, max_y - 1)
#         antipodal_points.add(antinode1)
#     end
#     if antinode2[0].between?(0, max_x - 1) && antinode2[1].between?(0, max_y - 1)
#         antipodal_points.add(antinode2)
#     end
# end

def add_valid_antipodal_points(position1, position2, max_x, max_y, antipodal_points, harmonics = false)
    antipodal_points.add(position1)
    antipodal_points.add(position2)
    x1, y1 = position1
    x2, y2 = position2
    y_dist = y2 - y1
    x_dist = x2 - x1
    antinode1 = [x1 - x_dist, y1 - y_dist]
    antinode2 = [x2 + x_dist, y2 + y_dist]
    while antinode1[0].between?(0, max_x - 1) && antinode1[1].between?(0, max_y - 1)
        antipodal_points.add(antinode1)
        if(!harmonics)
            break
        end
        antinode1 = [antinode1[0] - x_dist, antinode1[1] - y_dist]
    end
    while antinode2[0].between?(0, max_x - 1) && antinode2[1].between?(0, max_y - 1)
        antipodal_points.add(antinode2)
        if(!harmonics)
            break
        end
        antinode2 = [antinode2[0] + x_dist, antinode2[1] + y_dist]
    end
end


puts part_1
puts part_2