def check_swap_h(x, y, digit, direction)
  global_grid = $grid

  # The 2 on the top
  return true if y > 1 && global_grid[y - 2][x] == digit && global_grid[y - 1][x] == digit
  # The one on the top & bottom
  return true if y > 0 && y < 8 && global_grid[y - 1][x] == digit && global_grid[y + 1][x] == digit
  # The 2 on the bottom
  return true if y < 7 && global_grid[y + 1][x] == digit && global_grid[y + 2][x] == digit

  # The 2 on the right
  return true if direction == "left" && x < 7 && global_grid[y][x + 1] == digit && global_grid[y][x + 2] == digit
  # The 2 on the left
  return true if direction == "right" && x > 1 && global_grid[y][x - 1] == digit && global_grid[y][x - 2] == digit

  false
end

def check_swap_v(x, y, digit, direction)
  global_grid = $grid

  # The 2 on the left
  return true if x > 1 && global_grid[y][x - 2] == digit && global_grid[y][x - 1] == digit
  # The one of the left & right
  return true if x > 0 && x < 8 && global_grid[y][x - 1] == digit && global_grid[y][x + 1] == digit
  # The 2 on the right
  return true if x < 7 && global_grid[y][x + 1] == digit && global_grid[y][x + 2] == digit

  # The 2 on the top
  return true if direction == "up" && y > 1 && global_grid[y - 1][x] == digit && global_grid[y - 2][x] == digit
  # The 2 on the bottom
  return true if direction == "down" && y < 7 && global_grid[y + 1][x] == digit && global_grid[y + 2][x] == digit

  false
end

grid = []
9.times do
  grid << gets.chomp.split.map(&:to_i)
end
$grid = grid

swaps = []

(0...9).each do |y|
  (0...9).each do |x|
    # We can switch with the one on the right
    if x < 8
      if grid[y][x] != grid[y][x + 1] && (check_swap_h(x + 1, y, grid[y][x], "left") || check_swap_h(x, y, grid[y][x + 1], "right"))
        swaps << "#{y} #{x} #{y} #{x + 1}"
      end
    end
    # We can switch with the one on the bottom
    if y < 8
      if grid[y + 1][x] != grid[y][x] && (check_swap_v(x, y + 1, grid[y][x], "down") || check_swap_v(x, y, grid[y + 1][x], "up"))
        swaps << "#{y} #{x} #{y + 1} #{x}"
      end
    end
  end
end

puts swaps.count
puts swaps.join("\n")