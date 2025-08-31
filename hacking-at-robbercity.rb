def xor(first_hex_string, second_hex_string)
  result = ''
  (0...first_hex_string.length).each do |index|
    result += (first_hex_string[index].to_i(16) ^ second_hex_string[index].to_i(16)).to_s(16)
  end
  result
end

puts xor(xor(gets.chomp, gets.chomp), gets.chomp).gsub(/../) { |x| x.to_i(16).chr }