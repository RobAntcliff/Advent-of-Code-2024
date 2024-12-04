class Day4
  @@xmas_chars = []
  File.readlines("day_4_input.txt").map do |line|
    @@xmas_chars << line.chomp.chars
  end

  def part_1
    result = find_number_of_xmas(@@xmas_chars)
    puts result
  end

  def part_2
    result = find_number_of_x_mas(@@xmas_chars)
    puts result
  end

  def find_number_of_xmas(input)
    result = 0
    input.each_with_index do |line, i|
      line.each_with_index do |c, j|
        if(c == 'X')
          result += number_of_xmas(input, i, j, c)
        end
      end
    end

    result
  end

  def find_number_of_x_mas(input)
    result = 0
    input.each_with_index do |line, i|
      line.each_with_index do |c, j|
        if(c == 'A')
          result += 1 if is_x_mas(input, i, j)
        end
      end
    end

    result
  end

  def number_of_xmas(input, i, j, c)
    xmas = ['X', 'M', 'A', 'S']
    result = 0
    directions = [-1, 0, 1]
    
    directions.each do |x|
      directions.each do |y|
        count = 0
        current_char = c
        x_axis = x
        y_axis = y
        while(count < 3)
          next_expected_char_index = xmas.find_index(current_char).next
          next_expected_char = xmas[next_expected_char_index]
          if(i + x_axis >= 0 && i + x_axis < input.length() && j + y_axis >=0 && j + y_axis < input[0].length())
            if(input[i + x_axis][j + y_axis] != nil && input[i + x_axis][j + y_axis] == next_expected_char)
              current_char = next_expected_char
              count += 1
              x_axis += x
              y_axis += y
            else
              break
            end
          else
            break
          end
        end
        if(count == 3)
          result += 1
        end
      end
    end

    result
  end

  def is_x_mas(input, i, j)
    valid_input = i - 1 >= 0 && i + 1 < input.length() && j - 1 >=0 && j + 1 < input[0].length()
    necessary_chars = ['M', 'S']
 
    if valid_input &&
      input[i-1][j-1] != input[i+1][j+1] &&
      (input[i-1][j-1] == input[i-1][j+1] || input[i-1][j-1] == input[i+1][j-1]) &&
      (input[i+1][j+1] == input[i-1][j+1] || input[i+1][j+1] == input[i+1][j-1]) &&
      (necessary_chars.include?(input[i-1][j-1])) &&
      (necessary_chars.include?(input[i+1][j+1]))

      return true
    end

    false
  end
end



day4 = Day4.new
day4.part_1
day4.part_2