# Get user input
gets

# Calculate the total stone value
stone_value = (gets.split.map(&:to_i).map { |x| 2 ** x }).sum

# Print the sum of the binary representation of the stone value
puts (stone_value.to_s(2).chars.map(&:to_i).sum)