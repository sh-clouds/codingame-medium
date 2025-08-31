W, H = gets.split.map(&:to_i)
X, Y = gets.split.map(&:to_i)
maze = []
H.times do
  maze << gets.strip.chars
end

exits = []
to_check = [[X, Y]]
visited = []

while to_check.any?
  x, y = to_check.pop

  # Don't visit the same position multiple times
  next if visited[y] && visited[y][x]
  visited[y] ||= {}
  visited[y][x] = true

  # We found an exit
  if x == 0 || x == W - 1 || y == 0 || y == H - 1
    exits << [x, y]
    next
  end

  # Check the 4 directions
  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |xm, ym|
    xu = x + xm
    yu = y + ym

    to_check << [xu, yu] if maze[yu][xu] != "#"
  end
end

# Sort exit coordinates by X, Y
exits.sort_by! { |coordinates| [coordinates[0], coordinates[1]] }

puts exits.size
if exits.any?
  puts exits.map { |coordinates| coordinates.join(" ") }
end