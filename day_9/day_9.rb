def part_1
    input = File.read("day_9_input.txt")
    puts get_checksum(input)
end

def part_2
    input = File.read("day_9_input.txt")
    return p2_get_checksum(input)
end

def p2_get_checksum(input)
    checksum = 0

    input_arr = []

    input.each_char.with_index do |val, i|
        input_arr << val.to_i
    end

    # puts input_arr.inspect
    temp_arr = input_arr.dup

    # puts temp_arr.inspect
    
    end_pointer = input.length - (input.length % 2)
    end_pointer_id = input.length / 2

    # calculate checksum value for moved data

    # iterate through original data and only calc checksum for values not moved

    moved_values = Set.new

    temp_arr.reverse.each_with_index do |val, i|
      id = (input.length / 2) - (i / 2)
      #puts "ID: " + id.to_s + " Val: " + val.to_s

      if(i % 2 == 1)
        next
      else
        id_count = 0
        temp_arr.each_with_index do |val2, j|
            # puts "ID Count: " + id_count
            if j >= id * 2
                break
            end
            #empty space
            if(j % 2 == 1 && val2 >= val)
                moved_values << id
                temp_arr[j] -= val
                temp_arr[j-1] += val
                temp_id_count = id_count.dup
                while(val > 0)
                    checksum += temp_id_count * id
                    puts "Calc = " + temp_id_count.to_s + " * " + id.to_s
                    val -= 1
                    temp_id_count += 1
                end
                #puts "Updated Checksum: " + checksum.to_s
                break
            else
                # adding the values so we know what the mult is
                id_count += val2
            end
        end
      end
      #puts "New Array: " + temp_arr.inspect
    end

    # puts temp_arr.inspect

    puts "First calc checksum: " + checksum.to_s

    # puts moved_values

    modified_checksum = get_checksum_modified(input, moved_values)
    puts "Modified checksum: " + modified_checksum.to_s

    checksum += modified_checksum
    checksum
end

def get_checksum_modified(input, moved_values)
    checksum = 0
    running_id_val = 0
    input.each_char.with_index do |val, i|
        id = i / 2
        #empty
        if(i % 2 == 1)
            running_id_val += val.to_i
        else
            if !moved_values.include?(id)
                temp_val = val.to_i.dup
                while(temp_val > 0)
                    checksum += running_id_val * id
                    #puts "Calc = " + running_id_val.to_s + " * " + id.to_s
                    temp_val -= 1
                    running_id_val += 1
                end
            else
                running_id_val += val.to_i
            end
        end
    end

    checksum
end

def get_checksum(input)
    checksum = 0
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
                #puts "Move Start Pointer to: " + start_pointer.to_s
            elsif(curr_end_id_count == 0)
                ## Move to the next value
                end_pointer -= 2
                curr_end_id_count = input[end_pointer].to_i
                end_pointer_id -= 1
                #puts "Move End Pointer to: " + end_pointer.to_s
            else
                checksum += count * end_pointer_id
                #puts "End mult: " + count.to_s + " * " + end_pointer_id.to_s + " Curr Start Id Count = " + curr_start_id_count.to_s + ", Start Pointer: " + start_pointer.to_s + ", End Pointer" + end_pointer.to_s
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
                #puts "Move Start Pointer to: " + start_pointer.to_s
            else
                #puts "Start Mult: " + count.to_s + " * " + start_pointer_id.to_s + ", Start Pointer: " + start_pointer.to_s + ", End Pointer" + end_pointer.to_s
                checksum += count * start_pointer_id
                count += 1
                curr_start_id_count -= 1
            end
        end
    end

    checksum
end

# start_time = Time.now
# puts "Part 1: #{part_1}"
# puts "Time taken: #{Time.now - start_time} seconds"

start_time = Time.now
puts "Part 2: #{part_2}"
puts "Time taken: #{Time.now - start_time} seconds"