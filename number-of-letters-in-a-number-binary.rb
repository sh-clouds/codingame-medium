s, n = gets.chomp.split.map(&:to_i)
n.times do
  letter_count = 3 * s.to_s(2).count("1") + 4 * s.to_s(2).count('0') # 'one', 'zero'
  # check the repeat pattern in outputs
  break if letter_count == s
  s = letter_count
end
puts s