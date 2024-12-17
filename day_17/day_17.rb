def part_1
  # 3 Registers A, B and C
  # 
  # 8 instructions determined by opcode
  # Each instruction reads the number after it as an input (the operand)
  # 
  # Instruction pointer (IP) identifies the position from where the next opcode will be read
  # Is increased by 2 after each instruction except for jumps
  # 
  # Program halts when it tries to read an opcode past the end of the program
  # 
  # 2 types of operand:
  #  Literal
  #   - 0 to 3 represent literal values 0 to 3
  #  Combo
  #   - 4 represents register A
  #   - 5 represents register B
  #   - 6 represents register C
  #   
  #
  

  registers = {
    a: 0,
    b: 0,
    c: 0
  }

  program = []

  # Instruction pointer
  ip = 0

  File.read(File.join(__dir__, "test_input.txt")).split("\n").each do |line|
    if line.include?("Register A:")
      registers[:a] = line.split(":").last.strip.to_i
    elsif line.include?("Register B:")
      registers[:b] = line.split(":").last.strip.to_i
    elsif line.include?("Register C:")
      registers[:c] = line.split(":").last.strip.to_i
    elsif line.include?("Program:")
      program = line.split(":").last.strip.split(",").map(&:to_i)
    end
  end

  puts program.inspect

  opcodes = {
    adv: 0,
    bxl: 1,
    bst: 2,
    jnz: 3,
    bxc: 4,
    out: 5,
    bdv: 6,
    cdv: 7
  }

  result = []

  while ip + 1 < program.length
    opcode = program[ip]
    operand = program[ip + 1]

    case opcode
    when opcodes[:adv]
    # Performs Division
    numerator = registers[:a]
    denominator = 2**get_combo_value(operand, registers)

    registers[:a] = numerator / denominator
    when opcodes[:bxl]
      # Calculates the bitwise XOR of register B and the instruction's literal operand
      registers[:b] = registers[:b] ^ operand
    when opcodes[:bst]
      # Calculates value of it's combo operand modulo 8
      registers[:b] = get_combo_value(operand, registers) % 8
    when opcodes[:jnz]
      # Does nothing if the A register is 0
      unless registers[:a] == 0
        # Jumps by setting the instruction pointer to the value of the literal operand
        ip = operand

        # Make sure to not increase the ip by 2
        ip -= 2
      end
    when opcodes[:bxc]
      # Calculates the bitwise XOR or register B and Register C and stores the result in register B
      registers[:b] = registers[:b] ^ registers[:c]
    when opcodes[:out]
      # Calculates the value of its combo operand modulo 8, then outputs that value
      result << get_combo_value(operand, registers) % 8
    when opcodes[:bdv]
      # Performs Division
      numerator = registers[:a]
      denominator = 2**get_combo_value(operand, registers)

      registers[:b] = numerator / denominator
    when opcodes[:cdv]
      # Performs Division
      numerator = registers[:a]
      denominator = 2**get_combo_value(operand, registers)

      registers[:c] = numerator / denominator
    else
      puts "Huh?"
    end

    ip += 2
  end

  [result, registers]
end

def get_combo_value(combo, registers)
  case combo
  when 0, 1, 2, 3
    combo.to_i
  when 4
    registers[:a]
  when 5
    registers[:b]
  when 6
    registers[:c]
  end
end

def part_2
  # I think we can work backwards from the result
  
  starting_result = part_1

end

start_time = Time.now
part_1[0].join(",")
puts "Time taken to run part 1: #{Time.now - start_time} seconds"