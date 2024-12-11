def number_of_rocks_after_blinks(blinks)
    input = File.read("day_11_input.txt").split(" ").map(&:to_i)
    number_set = {}
    input.each do |element|
        number_set[element] = (number_set[element] || 0) + 1
    end

    blinks.times do |i|
        new_set = {}
        number_set.each do |element, count|
            next if count <= 0
            if element == 0
                new_set[1] = (new_set[1] || 0) + count
                next
            end

            if element.to_s.length.even?
                length = (Math.log10(element.abs)).floor() + 1
                divisor = 10**(length / 2)
                left_half = element / divisor
                right_half = element - (left_half * divisor)
                
                new_set[left_half.to_i] = (new_set[left_half.to_i] || 0) + count
                new_set[right_half.to_i] = (new_set[right_half.to_i] || 0) + count
            # else, the stone is multiplied by 2024
            else
                new_set[element * 2024] = (new_set[element * 2024] || 0) + count
            end
        end
        number_set = new_set
    end
    return number_set.values.sum
end

start_time = Time.now
puts "Part 1: #{number_of_rocks_after_blinks(25)}"
puts "Part 1 took #{Time.now - start_time} seconds to run"

start_time = Time.now
puts"Part 2: #{number_of_rocks_after_blinks(75)}"
puts "Part 2 took #{Time.now - start_time} seconds to run"