def solve(n)
  # Create an array to store the number of partitions for each number up to n
  partitions = Array.new(n + 1, 0)
  partitions[0] = 1  # There's one way to partition 0 (the empty partition)

  # Iterate through each number from 1 to n to build up the partitions array
  (1..n).each do |i|
    (i..n).each do |j|
      partitions[j] += partitions[j - i]
    end
  end

  # The number of partitions of n is now stored in partitions[n]
  partitions
end

T = gets.to_i
inputs = []
T.times do
  inputs << gets.to_i
end

results = solve(inputs.max)

inputs.each do |n|
  puts results[n]
end
