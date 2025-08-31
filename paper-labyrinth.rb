start = gets.split.map(&:to_i)
rabbit = gets.split.map(&:to_i)
W, H = gets.split.map(&:to_i)
grid = []
H.times do
  grid << gets.chomp.chars.map { "%04b" % _1.hex }
end

def astar(grid, start, finish)
  queue = [[*start, 0]]
  visited = {}
  while queue.any?
    *current, distance = queue.shift
    return distance if current == finish

    visited[current] = true
    x, y = current
    neighbours = []
    neighbours << [x + 1, y] unless grid[y][x][0] == ?1
    neighbours << [x - 1, y] unless grid[y][x][2] == ?1
    neighbours << [x, y + 1] unless grid[y][x][3] == ?1
    neighbours << [x, y - 1] unless grid[y][x][1] == ?1
    neighbours.each do |nx, ny|
      next if (visited[[nx, ny]] || nx < 0 || nx >= W || ny < 0 || ny >= H)

      queue << [nx, ny, distance + 1]
    end
  end
end

puts [astar(grid, start, rabbit), astar(grid, rabbit, start)].join(" ")
