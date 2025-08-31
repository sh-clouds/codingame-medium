
height = 0
prizes = []
board = []

height = gets.to_i
board = Array.new(height) { Array.new }
(0...height).each do |i|
  board[i] = gets.chomp.chars.map { |ch| ch.to_i }
end
prizes = Array.new(height + 1) { 0 }
(0...(height + 1)).each do |i|
  prizes[i] = gets.to_i
end

(1...height).each do |i|
  board[i][0] += board[i - 1][0]
  board[i][i] += board[i - 1][i - 1]
  (1...i).each do |j|
    board[i][j] += [board[i - 1][j - 1], board[i - 1][j]].max
  end
end
prizes[0] *= board[height - 1][0]
prizes[height] *= board[height - 1][height - 1]
(1...height).each do |i|
  prizes[i] *= [board[height - 1][i - 1], board[height - 1][i]].max
end
puts prizes.max

