def part_1
    return File.open("day_7_input.txt").map do |line|
        Thread.new() do
            input_array = line.chomp.split(" ")
            target_number = input_array[0].to_i
            numbers = input_array[1..-1].map(&:to_i)
            if number_can_be_created(target_number, numbers, ['+', '*'])
                target_number
            else
                0
            end
        end
    end.map(&:value).sum
end

def part_2
    return File.open("day_7_input.txt").map do |line|
        Thread.new() do
            input_array = line.chomp.split(" ")
            target_number = input_array[0].to_i
            numbers = input_array[1..-1].map(&:to_i)
            if number_can_be_created(target_number, numbers, ['+', '*', '||'])
                target_number
            else
                0
            end
        end
    end.map(&:value).sum
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

start_time = Time.now
puts part_1
puts part_2
end_time = Time.now
puts "Time taken: #{end_time - start_time} seconds"