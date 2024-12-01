class Day1
  @@array_0 = Array.new
  @@array_1 = Array.new

  def initialize
    File.foreach("day_1_input.txt") do |line|
      values = line.split
      @@array_0 << Integer(values[0])
      @@array_1 << Integer(values[1])
    end
  end

  def day_1_part_1()
    @sorted_array_0 = @@array_0.sort
    @sorted_array_1 = @@array_1.sort

    @result = 0

    @sorted_array_0.zip(@sorted_array_1).each do |val1, val2|
      @result += (val1 - val2).abs
    end

    puts @result
  end

  def day_1_part_2()
    @dictionary = {}
    @result = 0

    @@array_1.each do |val|
      @dictionary.key?(val) ? @dictionary[val] += 1 : @dictionary[val] = 1
    end

    @@array_0.each do |val|
      if @dictionary.key?(val)
        @result += val * @dictionary[val]
      end
    end

    puts @result
  end
end

day1 = Day1.new
day1.day_1_part_1
day1.day_1_part_2