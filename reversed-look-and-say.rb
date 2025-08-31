def nx(input_string)
  if input_string.length % 2 == 1
    return input_string
  end

  previous_character = -1
  result_string = ""
  
  (0...(input_string.length / 2).to_i).each do |index|
    if input_string[index * 2 + 1] == previous_character
      return input_string #
    end
    
    result_string += input_string[index * 2 + 1] * input_string[index * 2].to_i
    previous_character = input_string[index * 2 + 1]
  end
  
  return result_string
end

input_string = gets.chomp
loop do
  transformed_string = nx(input_string)
  #if transformed_string.length % 2 == 1:break
  break if transformed_string == input_string
  input_string = transformed_string
end

puts input_string