def calc_cost(part)
  result = 0
  File.read(File.join(__dir__, "day_13_input.txt")).split("\n\n").map { |b| l = b.split("\n"); { x1: l[0].split("X+")[1].split(",")[0].to_i, x2: l[0].split("Y+")[1].to_i, y1: l[1].split("X+")[1].split(",")[0].to_i, y2: l[1].split("Y+")[1].to_i, e1: l[2].split("X=")[1].split(",")[0].to_i, e2: l[2].split("Y=")[1].to_i } }.each do |e|
    e[:e1] += 10000000000000 if part == 2
    e[:e2] += 10000000000000 if part == 2
    x, y = ((e[:e1] * e[:y2]) - (e[:e2] * e[:y1])) / ((e[:x1] * e[:y2]) - (e[:x2] * e[:y1])), (e[:e1] - (e[:x1] * ((e[:e1] * e[:y2]) - (e[:e2] * e[:y1])) / ((e[:x1] * e[:y2]) - (e[:x2] * e[:y1])))) / e[:y1]
    next if(((e[:e1] * e[:y2]) - (e[:e2] * e[:y1])) % ((e[:x1] * e[:y2]) - (e[:x2] * e[:y1])) != 0 || ((e[:e1] - (e[:x1] * x)) % e[:y1] != 0) || ((part == 1 ? 100 : nil) && (x > 100 || y > 100)))
    temp_result = (x * 3) + y
    result += temp_result if temp_result
  end
  result
end
[1, 2].each { |part| t = Time.now; puts "\n#{'Part ' + part.to_s} Result: #{calc_cost(part)} (#{Time.now - t}s)" }