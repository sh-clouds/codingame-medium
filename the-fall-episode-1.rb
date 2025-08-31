STDOUT.sync = true # DO NOT REMOVE

def make_turn(rotation, x_coordinate, y_coordinate, direction)
  if [2, 6].include?(rotation)
    if direction == "LEFT"
      x_coordinate += 1
    else
      x_coordinate -= 1
    end
  elsif rotation == 4
    if direction == "TOP"
      x_coordinate -= 1
    else
      y_coordinate += 1
    end
  elsif rotation == 5
    if direction == "TOP"
      x_coordinate += 1
    else
      y_coordinate += 1
    end
  elsif rotation == 10
    x_coordinate -= 1
  elsif rotation == 11
    x_coordinate += 1
  else
    y_coordinate += 1
  end
  puts "#{x_coordinate} #{y_coordinate}"
end

width, height = gets.split.map(&:to_i)
array = Array.new(height) { Array.new(width, 0) }
height.times do |i|
  input_values = gets.split(" ")
  width.times do |j|
    array[i][j] = input_values[j].to_i
  end
end
execution_value = gets.to_i

loop do
  inputs = gets.split
  x_index = inputs[0].to_i
  y_index = inputs[1].to_i
  position = inputs[2]
  make_turn(array[y_index][x_index], x_index, y_index, position)
end