class Day5
  def initialize
    @page_ordering_rules = { }
    @page_numbers = []
    rules_input = true;
    File.open("day_5_input.txt").each do |line|
      
      if line.strip.empty?
        rules_input = false
        next
      end

      if(rules_input == true)
        rule = line.split('|', -1).map(&:to_i)
        if(@page_ordering_rules.key?(rule[0]))
          @page_ordering_rules[rule[0]].add(rule[1])
        else
          @page_ordering_rules[rule[0]] = Set[rule[1]]
        end
      else
        @page_numbers << line.split(',').map(&:to_i)
      end
    end
  end

  def part_1
    result = 0
    @page_numbers.each do |page|
      valid_update = is_valid_update(page)

      if valid_update
        middle_index = page.length / 2
        result += page[middle_index]
      end
    end

    puts result;
  end

  def part_2
    result = 0

    @page_numbers.each do |page|
      valid_update = is_valid_update(page)

      if !valid_update
        sorted_array = page.sort do |a, b|
          if @page_ordering_rules.key?(a) && @page_ordering_rules[a].include?(b)
            -1
          elsif @page_ordering_rules.key?(b) && @page_ordering_rules[b].include?(a)
            1
          else
            a <=> b
          end
        end

        middle_index = sorted_array.length / 2
        result += sorted_array[middle_index]
      end
    end

    puts result;
  end

  def is_valid_update(page)
    valid_update = true
    page.each_with_index do |val, i|
      temp_i = i;
      while(temp_i >= 0)
        if @page_ordering_rules[val]
          if @page_ordering_rules[val].include?(page[temp_i])
            valid_update = false
          end
        end
        temp_i -= 1
      end
    end
    
    valid_update
  end
end

day5 = Day5.new
day5.part_1
day5.part_2