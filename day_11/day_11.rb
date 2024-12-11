def part_1()
    blinks = 25
    input = File.read("day_11_input.txt").split(" ").map(&:to_i)
    #puts input.inspect

    blinks.times do |i|
        #puts "Iteration " + i.to_s + ": " + input.length.to_s
        new_array = []
        input.each_with_index do |element, i|
            # If number = 0, replace with 1
            if element == 0
                new_array << 1
            # if number has even number of digits, replace with 2 stones
            # left half on left stone, right half on right stone
            elsif element.to_s.length.even?
                left_half = element.to_s[0..element.to_s.length / 2 - 1]
                right_half = element.to_s[element.to_s.length / 2..-1]

                new_array << left_half.to_i
                new_array << right_half.to_i
            # else, the stone is multiplied by 2024
            else
                new_array << element * 2024
            end
        end
        input = new_array
    end
    puts input.length
end

def part_2()
    blinks = 75
    input = File.read("day_11_input.txt").split(" ").map(&:to_i)
    #puts input.inspect

    amount_of_zeroes = input.count(0)
    numbers_to_split = input.select { |num| num.to_s.length.even? && num != 0 }
    numbers_to_multiply = input.select { |num| num.to_s.length.odd? && num != 0 }

    # Have a hash map, where the key is the element, and value id the amount of steps from that element

    number_set = {}
    input.each do |element|
        if number_set[element].nil?
            number_set[element] = 1
        else
            number_set[element] += 1
        end
    end

    blinks.times do |i|
        new_set = {}
        number_set.each do |element, count|
            next if count <= 0
            # If number = 0, replace with 1
            if element == 0
                if new_set[1].nil?
                    new_set[1] = count
                else
                    new_set[1] += count
                end
                next
            end
            # if number has even number of digits, replace with 2 stones
            # left half on left stone, right half on right stone

            if element.to_s.length.even?
                length = (Math.log10(element.abs)).floor() + 1
                divisor = 10**(length / 2)
                left_half = element / divisor
                right_half = element - (left_half * divisor)
                
                if new_set[left_half.to_i].nil?
                    new_set[left_half.to_i] = count
                else
                    new_set[left_half.to_i] += count
                end

                if new_set[right_half.to_i].nil?
                    new_set[right_half.to_i] = count
                else
                    new_set[right_half.to_i] += count
                end
            # else, the stone is multiplied by 2024
            else
                if new_set[element * 2024].nil?
                    new_set[element * 2024] = count
                else
                    new_set[element * 2024] += count
                end
            end
        end
        number_set = new_set
    end
    total = number_set.values.sum
    puts "Total: #{total}"
end

start_time = Time.now
part_1
puts "Part 1 took #{Time.now - start_time} seconds to run"

start_time = Time.now
part_2
puts "Part 2 took #{Time.now - start_time} seconds to run"