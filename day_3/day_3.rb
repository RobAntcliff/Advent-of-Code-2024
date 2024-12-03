class Day3
  def part_1 
    puts find_sum_of_mults(true)
  end

  def part_2
    puts find_sum_of_mults()
  end
  
  def find_sum_of_mults(part1 = false)
    result = 0
    matched_strings = File.read("day_3_input.txt").scan(/mul\([0-9]+,[0-9]+\)|don't\(\)|do\(\)/)
    mult_enabled = true
    matched_strings.each do |n|
      if n == "don't()"
        mult_enabled = false
      elsif n == "do()"
        mult_enabled = true
      elsif mult_enabled || part1
        numbers = n.scan(/[0-9]+/).map(&:to_i)
        result += numbers[0] * numbers[1]
      end
    end
    
    puts result
  end
end

day3 = Day3.new
day3.part_1
day3.part_2