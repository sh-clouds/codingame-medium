N = gets.to_i
B = gets.chomp
longest_substring = B.split('!').max_by(&:length)
puts (B.index(longest_substring) == 0) ? 0 : ((B.index(longest_substring) + longest_substring.length == N) ? (N - 1) : (B.index(longest_substring) + longest_substring.length / 2))