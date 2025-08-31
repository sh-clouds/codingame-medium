class LinkedCell
  attr_accessor :x, :y, :prev

  def initialize(x, y, prev)
    @x = x
    @y = y
    @prev = prev
  end
end


width, height = gets.split.map(&:to_i)
grid = Array.new(height) { gets.chomp }

x, y, length, index = 0, 0, 0, 0
while y < height
  x = grid[y].index('S')
  break unless x.nil?
  y += 1
end

path = Array.new(512)
path[length] = LinkedCell.new(x, y, nil)
length += 1
end_cell = nil

while end_cell.nil?
  previous = path[index]
  x_coord = previous.x
  y_coord = previous.y
  x_plus_one = (x_coord + 1) % width
  x_minus_one = (x_coord - 1 + width) % width
  y_plus_one = (y_coord + 1) % height
  y_minus_one = (y_coord - 1 + height) % height
  x_direction = y_coord.odd? ? x_plus_one : x_minus_one

  if grid[y_coord][x_plus_one] == 'E' || grid[y_coord][x_minus_one] == 'E' || 
     grid[y_plus_one][x_coord] == 'E' || grid[y_minus_one][x_coord] == 'E' || 
     grid[y_plus_one][x_direction] == 'E' || grid[y_minus_one][x_direction] == 'E'
    end_cell = previous
  else
    if grid[y_coord][x_plus_one] == '_'
      path[length] = LinkedCell.new(x_plus_one, y_coord, previous)
      length += 1
      grid[y_coord][x_plus_one] = ' '
    end
    if grid[y_coord][x_minus_one] == '_'
      path[length] = LinkedCell.new(x_minus_one, y_coord, previous)
      length += 1
      grid[y_coord][x_minus_one] = ' '
    end
    if grid[y_plus_one][x_coord] == '_'
      path[length] = LinkedCell.new(x_coord, y_plus_one, previous)
      length += 1
      grid[y_plus_one][x_coord] = ' '
    end
    if grid[y_minus_one][x_coord] == '_'
      path[length] = LinkedCell.new(x_coord, y_minus_one, previous)
      length += 1
      grid[y_minus_one][x_coord] = ' '
    end
    if grid[y_plus_one][x_direction] == '_'
      path[length] = LinkedCell.new(x_direction, y_plus_one, previous)
      length += 1
      grid[y_plus_one][x_direction] = ' '
    end
    if grid[y_minus_one][x_direction] == '_'
      path[length] = LinkedCell.new(x_direction, y_minus_one, previous)
      length += 1
      grid[y_minus_one][x_direction] = ' '
    end
  end
  index += 1
end

until end_cell.prev.nil?
  grid[end_cell.y][end_cell.x] = '.'
  end_cell = end_cell.prev
end

height.times do |i|
  width.times do |j|
    grid[i][j] = '_' if grid[i][j] == ' '
  end
  puts grid[i]
end
