require 'set'

width, height = gets.chomp.split.map(&:to_i) #the width and height of the grid
initial_x, initial_y = gets.chomp.split.map(&:to_i) #initial coordinates.
facing_directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]

direction = gets.chomp
direction_index = 0
case direction
when 'N'
  direction_index = 0
when 'E'
  direction_index = 1
when 'S'
  direction_index = 2
when 'W'
  direction_index = 3
end

grid = Array.new(height) { Array.new(width, '') }
turns_count = gets.chomp.to_i #the number of turns
(0...height).each do |i|
  line = gets.chomp
  (0...width).each do |j|
    grid[i][j] = line[j]
  end
end

(0...turns_count).each do |i|
  symbol = -1
  if grid[initial_y][initial_x] == '#'
    symbol = 1
  end
  direction_index = (direction_index + 4 + symbol) % 4 #exist in four direction

  if grid[initial_y][initial_x] == '#'
    grid[initial_y][initial_x] = '.'
  else
    grid[initial_y][initial_x] = '#'
  end
  initial_x += facing_directions[direction_index][0]
  initial_y += facing_directions[direction_index][1]
end

(0...height).each do |i|
  puts grid[i].join
end