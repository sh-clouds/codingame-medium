L = gets.to_i
N = gets.to_i

output = Array.new(L, 0)

N.times do
  pattern, tempo = gets.split
  tempo = tempo.to_i

  # Apply the pattern on each line
  (tempo..L).step(tempo) do |j|
    output[j - 1] |= pattern.tr('X', '1').to_i(2)
  end
end

# Convert back 'X' & '0' from binary
output.map! do |row|
  row.to_s(2).tr('1', 'X').rjust(4, '0')
end

puts output.reverse