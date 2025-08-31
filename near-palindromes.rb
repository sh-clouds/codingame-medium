def nb_error(text, nb = 0)
  return nb if text.length <= 1 || nb > 1

  left = text[0]
  right = text[-1]

  return [nb_error(text[1..-2], nb + (left != right ? 1 : 0)),
          nb_error(text[1..-1], nb + 1),
          nb_error(text[0..-2], nb + 1)].min
end

number_of_words = gets.to_i
result = ''
number_of_words.times do
  word = $stdin.gets.chomp
  result += nb_error(word) < 2 ? '1' : '0'
end
puts result