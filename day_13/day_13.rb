def part_1
  # Read and parse input file
  input = File.read(File.join(__dir__, "day_13_input.txt")).split("\n\n")
  
  # Process each block of coordinates
  coordinate_blocks = input.map do |block|
    lines = block.split("\n")

    x1 = lines[0].split("X+")[1].split(",")[0].to_i
    y1 = lines[0].split("Y+")[1].to_i

    x2 = lines[1].split("X+")[1].split(",")[0].to_i
    y2 = lines[1].split("Y+")[1].to_i

    prize_x = lines[2].split("X=")[1].split(",")[0].to_i
    prize_y = lines[2].split("Y=")[1].to_i
    
    {
      button_a: { x: x1.to_i, y: y1.to_i },
      button_b: { x: x2.to_i, y: y2.to_i },
      prize: { x: prize_x.to_i, y: prize_y.to_i }
    }
  end
 
  result = 0
  coordinate_blocks.each do |block|
    # Equation 1: x1 * y1 = e1
    x1 = block[:button_a][:x]
    y1 = block[:button_b][:x]
    e1 = block[:prize][:x]

    # Equation 2: x2 * y2 = e2
    x2 = block[:button_a][:y]
    y2 = block[:button_b][:y]
    e2 = block[:prize][:y]
    
    # Mult first equation by y from the second equation to eliminate y
    new_x1 = x1 * y2
    new_y1 = y1 * y2
    new_e1 = e1 * y2

    # mult second equation by y from the first equation
    new_x2 = x2 * y1
    new_y2 = y2 * y1
    new_e2 = e2 * y1

    # Eliminated y
    x3 = new_x1 - new_x2
    e3 = new_e1 - new_e2

    if(e3 % x3 != 0)
      next
    end

    x = e3 / x3

    if((e1 - (x1 * x)) % y1 != 0)
      next
    end

    y = (e1 - (x1 * x)) / y1

    if(x <= 100 && y <= 100)
      result += (x * 3) + y
    end
  end

  puts result
end

def part_2
  # Read and parse input file
  input = File.read(File.join(__dir__, "day_13_input.txt")).split("\n\n")
  
  # Process each block of coordinates
  coordinate_blocks = input.map do |block|
    lines = block.split("\n")

    x1 = lines[0].split("X+")[1].split(",")[0].to_i
    y1 = lines[0].split("Y+")[1].to_i

    x2 = lines[1].split("X+")[1].split(",")[0].to_i
    y2 = lines[1].split("Y+")[1].to_i

    prize_x = lines[2].split("X=")[1].split(",")[0].to_i + 10000000000000
    prize_y = lines[2].split("Y=")[1].to_i + 10000000000000
    
    {
      button_a: { x: x1.to_i, y: y1.to_i },
      button_b: { x: x2.to_i, y: y2.to_i },
      prize: { x: prize_x.to_i, y: prize_y.to_i }
    }
  end
 
  result = 0
  coordinate_blocks.each do |block|
    # Equation 1: x1 * y1 = e1
    x1 = block[:button_a][:x]
    y1 = block[:button_b][:x]
    e1 = block[:prize][:x]

    # Equation 2: x2 * y2 = e2
    x2 = block[:button_a][:y]
    y2 = block[:button_b][:y]
    e2 = block[:prize][:y]
    
    # Mult first equation by y from the second equation to eliminate y
    new_x1 = x1 * y2
    new_y1 = y1 * y2
    new_e1 = e1 * y2

    # mult second equation by y from the first equation
    new_x2 = x2 * y1
    new_y2 = y2 * y1
    new_e2 = e2 * y1

    # Eliminated y
    x3 = new_x1 - new_x2
    e3 = new_e1 - new_e2

    if(e3 % x3 != 0)
      next
    end

    x = e3 / x3

    if((e1 - (x1 * x)) % y1 != 0)
      next
    end

    y = (e1 - (x1 * x)) / y1

    result += (x * 3) + y
  end

  puts result
end

part_2