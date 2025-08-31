# Read width, height, and t from standard input
width = gets.to_i
height = gets.to_i
t = gets.to_i

grid = Array.new(height) { Array.new(width) }
px = 0
py = 0

(0...height).each do |y|
  line = gets.chomp

  x = 0
  line.each_char.with_index do |char, j|
    # Starting position
    if char == "V"
      px = x
      py = y
    end

    # Input is a single line, negative values take 2 characters
    grid[y][x] = (char == "-") ? char + line[j + 1] : char
    x += 1 if char != "-" || (char == "-" && line[j + 1])
  end
end

(0...t).each do |_|
  x = px + 1
  y = py + 1

  # Landing on a thermal value
  if grid[y][x] != "."
    y -= grid[y][x].to_i
  end

  # Pilot leaves the grid
  break if x < 0 || x >= width || y < 0 || y >= height

  px = x
  py = y
end

puts "#{px} #{height - py - 1}"