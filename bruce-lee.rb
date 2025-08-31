


encrypt = gets.chomp.split(" ")
key_array = []
value_array = []

index = 0
message_bit_length = 0
temp_string = ""
answer = ""

encrypt.each do |string|
  begin
    break if string.to_i != 0
  rescue StandardError
    break
  end

  if index.odd?
    value_array << string
    message_bit_length += string.length
  else
    if string.length > 2
      answer = "INVALID"
      break
    end

    key_array << string
  end

  index += 1
end

answer = "INVALID" if (key_array.size + value_array.size) != encrypt.length || message_bit_length % 7 != 0

if answer.empty?
  key_array.each_with_index do |key, i|
    temp_string += value_array[i].gsub("0", key == "0" ? "1" : "0")
    if temp_string.length >= 7
      char_code = temp_string[0, 7].to_i(2)
      answer += char_code.chr
      temp_string = temp_string[7..-1]
    end
  end
end

puts answer
