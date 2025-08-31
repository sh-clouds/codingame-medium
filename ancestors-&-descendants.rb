def count_dot(input_string)
  (0...input_string.length).each do |index|
    return index if input_string[index] != '.'
  end
  input_string.length
end

def get_no_dot(input_string)
  result_string = ""
  (0...input_string.length).each do |index|
    result_string += input_string[index] if input_string[index] != '.'
  end
  result_string
end

def vector_to_string(string_vector)
  result_string = ""
  (0...string_vector.length).each do |index|
    result_string += string_vector[index]
    result_string += " > " unless index == string_vector.length - 1
  end
  result_string
end

count = gets.to_i
current_depth = 0
current_strings = []
count.times do
  line = gets.chomp
  depth = count_dot(line)
  if current_depth != depth
    puts vector_to_string(current_strings)
    while current_depth > depth
      current_strings.pop
      current_depth -= 1
    end
  end
  current_strings << get_no_dot(line)
  current_depth += 1
end
puts vector_to_string(current_strings)