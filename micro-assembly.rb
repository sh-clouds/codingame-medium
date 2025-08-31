def parse_register(s)
  case s
  when "a"
    return 0
  when "b"
    return 1
  when "c"
    return 2
  when "d"
    return 3
  else
    return -1
  end
end

input_data = $stdin.read.strip.split("\n")
registers = input_data[0].split.map(&:to_i)
number_of_instructions = input_data[1].to_i

# Read instructions
instructions = input_data[2, number_of_instructions].map { |line| line.split }

# Execute program
index = 0
while index < number_of_instructions
  instruction = instructions[index]
  destination, operand1, operand2 = nil, nil, nil
  immediate_operand1, immediate_operand2 = nil, nil
  
  case instruction[0]
  when "MOV"
    destination = parse_register(instruction[1])
    immediate_operand1 = (operand1 = parse_register(instruction[2])) < 0
    registers[destination] = immediate_operand1 ? instruction[2].to_i : registers[operand1]
  when "ADD", "SUB"
    destination = parse_register(instruction[1])
    immediate_operand1 = (operand1 = parse_register(instruction[2])) < 0
    immediate_operand2 = (operand2 = parse_register(instruction[3])) < 0
    registers[destination] = (immediate_operand1 ? instruction[2].to_i : registers[operand1]) + 
                              (immediate_operand2 ? instruction[3].to_i : registers[operand2]) * (instruction[0] == "ADD" ? 1 : -1)
  when "JNE"
    destination = instruction[1].to_i
    operand1 = parse_register(instruction[2])
    immediate_operand2 = (operand2 = parse_register(instruction[3])) < 0
    if registers[operand1] != (immediate_operand2 ? instruction[3].to_i : registers[operand2])
      index = destination - 1
    end
  else
    raise ArgumentError, "Bad instruction: #{instruction[0]}"
  end
  index += 1
end

# Print registers
puts "#{registers[0]} #{registers[1]} #{registers[2]} #{registers[3]}"