# Read an integer from standard input
n = gets.to_i

# Initialize arrays for rows, columns, and diagonals
rows = Array.new(n, 0)
columns = Array.new(n, 0)
diagonals = Array.new(2, 0)
numbers = Array.new((1..(n * n)).to_a)
SUM = n * (n * n + 1) / 2

# Process each row of input
(0...n).each do |y|
  gets.strip.split(" ").each_with_index do |v, x|
    rows[y] += v.to_i
    columns[x] += v.to_i
    diagonals[0] += v.to_i if y == x
    diagonals[1] += v.to_i if x == (n - 1) - y
  end
end

# Check if any row, column or diagonal doesn't have the right sum
invalid = (columns + rows + diagonals).select { |value| value != SUM }

# Output result based on the count of invalid sums
puts invalid.count.positive? ? "MUGGLE" : "MAGIC"