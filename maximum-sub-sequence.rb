# Read an integer from standard input
number_of_inputs = gets.to_i
inputs = gets.chomp.split(" ")

check = {}

(0...number_of_inputs).each do |index|
  current_number = inputs[index].to_i

  if check.key?(current_number)
    check[current_number + 1] = check[current_number] + 1
    check.delete(current_number)
  else
    check[current_number + 1] = 1
  end
end

# Sort by value ascending, key descending
check = check.sort_by { |key, value| [value, -key] }.to_h

last_key = check.keys.last
length = check.values.pop

puts (last_key - length...last_key).to_a.join(" ")