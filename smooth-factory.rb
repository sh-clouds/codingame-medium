v = gets.chomp.to_i

values = [1]
index = [[0, 2], [0, 3], [0, 5]]  # We use a different index for 2, 3 & 5

while values.length < v
  # The next value for a winning game is the min among the three
  value = [values[index[0][0]] * index[0][1], 
           values[index[1][0]] * index[1][1], 
           values[index[2][0]] * index[2][1]].min

  # When we use the value we increase the index, we might increase the index of more than one
  index.each_with_index do |(i, m), idx|
    if values[i] * m == value
      index[idx][0] += 1
    end
  end

  values << value
end

puts values.sum