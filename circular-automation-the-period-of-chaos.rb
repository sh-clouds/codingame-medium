NEIGHBORHOOD = %w{111 11. 1.1 1.. .11 .1. ..1 ...}

line_length = gets.to_i
max_iter    = gets.to_i
rule        = ("%08b" % gets.to_i).tr('0', '.')
pattern     = '.' * (line_length / 2) + '1' + '.' * (line_length / 2)
patterns    = []
answer      = nil

max_iter.times do |i|
  if patterns.include?(pattern)
    answer = i - patterns.index(pattern)
    break
  end

  patterns << pattern
  warn pattern

  pattern = pattern[-1] + pattern + pattern[0] 
  pattern = line_length.times.map{ |i| rule[NEIGHBORHOOD.index(pattern[i..(i+2)])] }.join
end

puts answer || 'BIG'