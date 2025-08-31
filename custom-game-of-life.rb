# Read input values
height, width, number_of_steps = gets.chomp.split.map(&:to_i)

alive_cells = gets.chomp
dead_cells = gets.chomp

grid = []
height.times do
  grid << gets.chomp.tr(".O", "01") # We use 0 for dead and 1 for alive to be able to directly do additions
end

number_of_steps.times do
  step_grid = grid.map(&:dup)

  height.times do |y|
    width.times do |x|
      # Get the count of neighbors
      neighbors = -grid[y][x].to_i # If cell is alive don't count it in neighbors
      ([(y - 1), 0].max..[(y + 1), height - 1].min).each do |y2|
        ([(x - 1), 0].max..[(x + 1), width - 1].min).each do |x2|
          neighbors += grid[y2][x2].to_i
        end
      end

      # Cell dies
      if grid[y][x] == "1" && alive_cells[neighbors.to_i] == "0"
        step_grid[y][x] = "0"
      # Cell is brought back to life
      elsif grid[y][x] == "0" && dead_cells[neighbors.to_i] == "1"
        step_grid[y][x] = "1"
      end
    end
  end

  grid = step_grid
end

# Revert back to '.' for dead and 'O' for alive and print result
puts grid.map { |line| line.tr("01", ".O") }.join("\n")