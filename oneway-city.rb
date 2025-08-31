def factorial(start, finish)
  result = 1
  (start..finish).each do |number|
    result *= number
  end
  result.to_i
end

def combination(total, choose)
  factorial(total - choose + 1, total) / factorial(2, choose)
end

m = gets.to_i - 1
n = gets.to_i - 1

puts combination(m + n, n).to_s[0..999]
