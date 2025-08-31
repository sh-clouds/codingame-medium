n = gets.to_i
result = Array.new(105, 0)
amounts = Array.new(n) { gets.to_i }

def find_max_value(index, n, result, amounts)
  return 0 if index >= n
  if result[index] == 0
    option1 = amounts[index] + find_max_value(index + 2, n, result, amounts)
    option2 = find_max_value(index + 1, n, result, amounts)
    result[index] = [option1, option2].max
  end
  return result[index]
end

puts find_max_value(0, n, result, amounts)