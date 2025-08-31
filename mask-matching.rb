mask = gets.to_i(16)
binary = (mask.to_s(2)).chars
indexes = []
binary.each_with_index do |bit, index|
  indexes << index if bit == '1'
end
solution = []
count_of_ones = binary.count('1')
open_bits = '1' * count_of_ones
max_integers = open_bits.to_i(2)

if max_integers <= 15
  (1..max_integers).each do |i|
    b = i.to_s(2).rjust(count_of_ones, '0')
    count_of_ones.times do |j|
      binary[indexes[j]] = b[j]
    end
    solution << binary.join.to_i(2)
  end
  puts solution.join(",")
else
  (1..13).each do |i|
    b = i.to_s(2).rjust(count_of_ones, '0')
    count_of_ones.times do |j|
      binary[indexes[j]] = b[j]
    end
    solution << binary.join.to_i(2)
  end
  modified_open_bits = open_bits.chars
  modified_open_bits[-1] = '0'
  count_of_ones.times do |j|
    binary[indexes[j]] = modified_open_bits[j]
  end
  solution << binary.join.to_i(2)
  solution << mask
  puts [*solution[0..12], "...", *solution[13..-1]].join(",")
end