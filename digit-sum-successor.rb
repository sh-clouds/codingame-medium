N = gets.to_i

def digits_array_of(number)
  number.to_s.chars.map(&:to_i)
end

def sum_of_digits(number)
  digits_array_of(number).reduce(0) { |sum, current| sum + current }
end

def last_significant_digit_index(number)
  digits_array_of(number).each_with_index.reduce({ sum: sum_of_digits(N), last_index: -1 }) do |accumulator, (current, index)|
    sum = accumulator[:sum] == 0 ? accumulator[:sum] : accumulator[:sum] - current
    last_index = accumulator[:sum] == 0 ? accumulator[:last_index] : index
    { sum: sum, last_index: last_index }
  end[:last_index]
end

def next_rounded(number)
  index = last_significant_digit_index(number)
  digits_array = digits_array_of(number)
  factor = digits_array.length - 1 - index
  to_add = (10 - digits_array[index]) * (10 ** factor)
  number + to_add
end

def next_target(number)
  num_array = digits_array_of(number).reverse
  current_sum = sum_of_digits(number)
  target_sum = sum_of_digits(N)
  index = 0

  # Increase number in O(n) complexity
  while current_sum != target_sum do
    next_to_add = target_sum - current_sum
    num_array[index] = next_to_add >= 10 ? 9 : next_to_add
    number = num_array.reverse.join.to_i
    current_sum = sum_of_digits(number)
    index += 1
  end
  number
end

puts next_target(next_rounded(N))