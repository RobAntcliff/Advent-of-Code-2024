def part_1
    result = 0
    input = File.read("day_9_input.txt")

    start_pointer = 0
    end_pointer = input.length - (input.length % 2)

    # These are the ID values
    start_pointer_id = 0
    end_pointer_id = input.length / 2

    # There are the counts of how much of an ID we have left to use
    curr_start_id_count = input[start_pointer].to_i
    curr_end_id_count = input[end_pointer].to_i
    count = 0
    in_empty_pos = false

    while start_pointer <= end_pointer
        # When we're at an empty position, we want to multiply with the end pointer index value
        if(in_empty_pos)
            if(curr_start_id_count == 0)
                start_pointer += 1
                start_pointer_id += 1
                curr_start_id_count = input[start_pointer].to_i
                in_empty_pos = false
                puts "Move Start Pointer to: " + start_pointer.to_s
            elsif(curr_end_id_count == 0)
                ## Move to the next value
                end_pointer -= 2
                curr_end_id_count = input[end_pointer].to_i
                end_pointer_id -= 1
                puts "Move End Pointer to: " + end_pointer.to_s
            else
                result += count * end_pointer_id
                puts "End mult: " + count.to_s + " * " + end_pointer_id.to_s + " Curr Start Id Count = " + curr_start_id_count.to_s + ", Start Pointer: " + start_pointer.to_s + ", End Pointer" + end_pointer.to_s
                curr_end_id_count -= 1
                curr_start_id_count -= 1
                count += 1
            end
        else
            if(start_pointer_id == end_pointer_id)
                curr_start_id_count = curr_end_id_count
                curr_end_id_count -= 1
            end
            if(curr_start_id_count == 0)
                ## Move the start pointer to the next position, representing empty position
                start_pointer += 1
                curr_start_id_count = input[start_pointer].to_i
                in_empty_pos = true
                puts "Move Start Pointer to: " + start_pointer.to_s
            else
                puts "Start Mult: " + count.to_s + " * " + start_pointer_id.to_s + ", Start Pointer: " + start_pointer.to_s + ", End Pointer" + end_pointer.to_s
                result += count * start_pointer_id
                count += 1
                curr_start_id_count -= 1
            end
        end
    end

    result
end

def part_2

end

puts part_1
# puts part_2