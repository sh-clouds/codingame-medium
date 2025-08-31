n = gets.to_i

sum = 0

# 1 is a divisor of each numbers
# 2 is a divisor of each 2th numbers
# 3 is a divisor of each 3th numbers
# X will be a divisor of floor(N/X) numbers
(1..n).each do |i|
  sum += n / i * i
end

puts sum