def calc_cost(part)
  equations = parse_input("day_13_input.txt")
  result = 0
  limit = part == 1 ? 100 : nil
  equations.each do |e|
    if(part == 2)
      e[:e1] += 10000000000000
      e[:e2] += 10000000000000
    end
    temp_result = do_algebra(e[:x1], e[:y1],e[:e1], e[:x2], e[:y2], e[:e2], limit)
    result += temp_result if temp_result
  end
  return result
end

def do_algebra(x1, y1, e1, x2, y2, e2, limit = nil)
  x = ((e1 * y2) - (e2 * y1)) / ((x1 * y2) - (x2 * y1))
  y = (e1 - (x1 * x)) / y1
  if(((e1 * y2) - (e2 * y1)) % ((x1 * y2) - (x2 * y1)) != 0 || ((e1 - (x1 * x)) % y1 != 0) || (limit && (x > limit || y > limit)))
    return nil
  end
  return (x * 3) + y
end

def parse_input(input_file)
  return File.read(File.join(__dir__, input_file)).split("\n\n").map { |b| l = b.split("\n"); { x1: l[0].split("X+")[1].split(",")[0].to_i, x2: l[0].split("Y+")[1].to_i, y1: l[1].split("X+")[1].split(",")[0].to_i, y2: l[1].split("Y+")[1].to_i, e1: l[2].split("X=")[1].split(",")[0].to_i, e2: l[2].split("Y=")[1].to_i } }
end

start_time = Time.now
puts "Part 1 Result: #{calc_cost(1)}"
puts "Time taken to run part 1: #{Time.now - start_time} seconds"

start_time = Time.now
puts "\nPart 2 Result: #{calc_cost(2)}"
puts "Time taken to run part 2: #{Time.now - start_time} seconds"
  