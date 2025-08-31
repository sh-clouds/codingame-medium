require 'set'

dirs = gets.chomp.split(" ")
nbs = gets.chomp.split(" ").map(&:to_i)
moves = [[0, 1], [0, -1], [1, 0], [-1, 0]]

on_positions = Set.new
position = [0, 0]

dirs.each_with_index do |direction, dir_index|
  nbs[dir_index].times do
    vec = moves["NSEW".index(direction)]
    position = [position[0] + vec[0], position[1] + vec[1]]

    if on_positions.include?(position)
      on_positions.delete(position)
    else
      on_positions.add(position)
    end
  end
end

if on_positions.empty?
  puts "."
  exit
end

x_min = on_positions.map { |a| a[0] }.min
x_max = on_positions.map { |a| a[0] }.max
y_min = on_positions.map { |a| a[1] }.min
y_max = on_positions.map { |a| a[1] }.max

(y_max).downto(y_min) do |i|
  (x_min..x_max).each do |j|
    print on_positions.include?([j, i]) ? "#" : "."
  end
  puts
end