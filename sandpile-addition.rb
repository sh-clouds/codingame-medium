sandpile_matrix = Array.new(10) { Array.new(10, 0) }

# check the grains per pile
def check_grains(matrix, size)
  (0...size).each do |i|
    (0...size).each do |j|
      return true if matrix[i][j] > 3
    end
  end
  false
end

n = gets.to_i
(0...n).each do |i|
  row = gets.chomp
  (0...row.size).each do |j|
    sandpile_matrix[i][j] = row[j].to_i
  end
end

(0...n).each do |i|
  row = gets.chomp
  (0...row.size).each do |j|
    sandpile_matrix[i][j] += row[j].to_i
  end
end

while check_grains(sandpile_matrix, n)
  (0...n).each do |i|
    (0...n).each do |j|
      if sandpile_matrix[i][j] > 3
        # add the grains to neighbors
        grains_to_add = sandpile_matrix[i][j] / 4
        sandpile_matrix[i][j] %= 4
        sandpile_matrix[i + 1][j] += grains_to_add if i + 1 < n
        sandpile_matrix[i][j + 1] += grains_to_add if j + 1 < n
        sandpile_matrix[i - 1][j] += grains_to_add if i - 1 >= 0
        sandpile_matrix[i][j - 1] += grains_to_add if j - 1 >= 0
      end
    end
  end
end

(0...n).each do |i|
  (0...n).each do |j|
    print sandpile_matrix[i][j]
  end
  puts
end
