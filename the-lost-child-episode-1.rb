class Position
  attr_accessor :x, :y, :dist, :access, :vis, :neighbours

  def initialize
    @x = -1
    @y = -1
    @dist = 0
    @access = true
    @vis = false
    @neighbours = []
  end

  def valid?
    @x >= 0 && @y >= 0 && @x < 10 && @y < 10
  end

  def accessible?
    @access
  end

  def set_position(u, v)
    @x = u
    @y = v
  end
end

def valid(x, y)
  x >= 0 && y >= 0 && x < 10 && y < 10
end

def initialize_grid(grid)
  grid.each_with_index do |row, i|
    row.each_index do |j|
      current_position = grid[i][j]
      current_position.set_position(i, j)

      current_position.neighbours << grid[i - 1][j] if valid(i - 1, j)
      current_position.neighbours << grid[i + 1][j] if valid(i + 1, j)
      current_position.neighbours << grid[i][j - 1] if valid(i, j - 1)
      current_position.neighbours << grid[i][j + 1] if valid(i, j + 1)
    end
  end
end

def bfs(source, destination, grid)
  raise "Source or destination is not set!" if source.nil? || destination.nil?
  raise "Source is invalid!" unless source.valid?
  raise "Destination is invalid!" unless destination.valid?

  source.vis = true

  queue = []
  queue.push(source)

  until queue.empty?
    current_position = queue.shift

    return current_position.dist if current_position == destination

    current_position.neighbours.each do |neighbour|
      if neighbour.valid? && neighbour.accessible? && !neighbour.vis
        neighbour.vis = true
        neighbour.dist = current_position.dist + 10

        queue.push(neighbour)
      end
    end
  end

  0
end

# main execution
grid = Array.new(10) { Array.new(10) { Position.new } }
start_position = nil
end_position = nil

10.times do |i|
  row = gets.chomp

  row.each_char.with_index do |char, j|
    case char
    when '#'
      grid[i][j].access = false
    when 'M'
      end_position = grid[i][j]
    when 'C'
      start_position = grid[i][j]
    end
  end
end

initialize_grid(grid)

puts "#{bfs(start_position, end_position, grid)}km"
