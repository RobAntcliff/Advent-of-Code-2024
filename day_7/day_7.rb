class Day7
    def part_1
        puts result_with_operations(['+', '*'])
    end

    def part_2
        puts result_with_operations(['+', '*', '||'])
    end

    def result_with_operations(operations)
        result = 0
        File.open("day_7_input.txt").each do |line|
            input_array = line.chomp.split(" ")
            target_number = input_array[0].to_i
            numbers = input_array[1..-1].map(&:to_i)
            result += target_number if number_can_be_created(target_number, numbers, operations)
        end
        return result
    end

    def number_can_be_created(target_number, numbers, operations)
        operations_combinations = generate_all_operation_combinations(numbers.length - 1, operations)
        operations_combinations.each do |operations_array|
            return true if is_valid_expression(target_number, numbers, operations_array)
        end
        false
    end

    def is_valid_expression(target_number, numbers, operations_array)
        to_check = numbers[0]
        operations_array.each_with_index do |to_operate, index3|
            if to_operate == '||'
                to_check = (to_check.to_s + numbers[index3 + 1].to_s).to_i
            elsif to_operate == '+'
                to_check += numbers[index3 + 1]
            else
                to_check *= numbers[index3 + 1]
            end
        end
        return true if to_check == target_number
        false
    end

    def generate_all_operation_combinations(length, operations)
        operations.repeated_permutation(length).to_a
    end

end

day7 = Day7.new
day7.part_1
day7.part_2