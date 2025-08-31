n = gets.to_i
result = []
while n > 0
  n, remainder = n.divmod(9)
  if remainder == 0
    remainder = 9
    n -= 1
  end
  result << remainder
end

puts result.reverse.join("")