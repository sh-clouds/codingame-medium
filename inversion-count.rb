# Read input values from standard input
input_values = gets.chomp.split.map(&:to_i)
modulus, multiplier, start_value, number_count = input_values

# Generate the numbers in the array
list = Array.new(number_count)
number_count.times do |index|
  list[index] = multiplier * (list[index - 1] || start_value) % modulus
end

# Passing the array instead of the start/end IDs takes more memory but is faster
def merge_sort(list)
  length = list.length

  return 0 if length == 1

  middle = length / 2

  left = list[0...middle]
  right = list[middle...length]

  count = merge_sort(left) # Sort the left array
  count += merge_sort(right) # Sort the right array

  index_left = 0
  index_right = 0

  # Merge left & right arrays
  length.times do |i|
    if (left[index_left] || Float::INFINITY) > (right[index_right] || Float::INFINITY)
      list[i] = right[index_right]
      index_right += 1
      # The smallest value is in the right, we increase the inversion by the # of numbers still waiting to be added in the left array
      count += middle - index_left
    else
      list[i] = left[index_left]
      index_left += 1
    end
  end
  count
end

puts merge_sort(list)