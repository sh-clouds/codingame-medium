n = gets.to_i
s = gets.strip

longest_balanced_length = 0
positions = Array.new(n, 0)

(0...n).each do |i|
  count = 0 # A substring is balanced when the count is 0

  # Find the smallest balanced substring ending at position i
  (i).downto(0) do |j|
    # Increase/Decrease the count
    if s[j] == '0'
      count -= 1
    else
      count += 1
    end

    # We found a balanced substring
    if count == 0
      # The number of balanced substring ending at i is the number of balanced substring ending at (j - 1) plus one
      positions[i] = positions[j - 1] + 1 if j > 0
      longest_balanced_length = [longest_balanced_length, positions[i]].max

      break
    end
  end
end

puts longest_balanced_length
