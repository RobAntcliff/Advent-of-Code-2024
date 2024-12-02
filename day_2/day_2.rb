class Day2
  def day_2_part_1(dampener = false)
    result = 0
    File.foreach("day_2_input.txt") do |report|
      levels = report_to_levels_array(report)
      safe = is_reactor_safe(levels, dampener)
      result += 1 if safe
    end
    
    puts result
  end

  def day_2_part_2()
    result = day_2_part_1(true)
    puts result
  end

  def report_to_levels_array(number_string)
    result = []
    values = number_string.split
    values.each do |v|
      result << Integer(v)
    end

    result
  end

  def is_reactor_safe(levels, dampener)
    increasing = levels[1] > levels[0]
    safe = true

    levels.each_with_index do |level, i|
      next if i == 0

      difference_disparity = (levels[i-1] - level).abs <= 0 || (levels[i-1] - level).abs > 3
      increase_disrupted = levels[i-1] > level && increasing
      decrease_disrupted = levels[i-1] < level && !increasing

      if difference_disparity || increase_disrupted || decrease_disrupted
        if dampener
          safe = dampened_check(levels, i)
          break
        end
        safe = false
        break
      end
    end

    safe
  end

  def dampened_check(levels, index)
    while index >= 0
      dampened_levels = levels.dup.tap{|j| j.delete_at(index)}
      safe = is_reactor_safe(dampened_levels, false) 
      return true if safe
      index -= 1
    end
    return false
  end
end

day2 = Day2.new
day2.day_2_part_1
day2.day_2_part_2