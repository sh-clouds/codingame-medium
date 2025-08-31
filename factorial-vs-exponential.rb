def solve(value)
  log_value = Math.log(value)
  factorial = 0
  n = 1

  while n * log_value >= factorial
    n += 1
    factorial += Math.log(n)
  end

  n
end

K = gets.to_i

solutions = []
gets.strip.split.map(&:to_f).each do |value|
  solutions << solve(value)
end

puts solutions.join(" ")
