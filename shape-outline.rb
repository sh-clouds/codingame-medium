# Read input values
height = gets.to_i
width = gets.to_i
scale = gets.to_i

grid = []
height.times do
  grid << gets.strip.chars
end

direction = "RIGHT"
current_y = 0
current_x = grid[0].index('#')
traversal_history = {}
edges = ["#{current_x * scale} 0"]

loop do
  if traversal_history.key?([current_y, current_x, direction])
    break  # We are back at the start of the shape
  else
    traversal_history[[current_y, current_x, direction]] = 1
  end

  if direction == "RIGHT"
    # Switching UP
    if (current_y - 1 >= 0 && current_x + 1 < width && grid[current_y - 1][current_x + 1] == '#')
      edges << "#{(current_x + 1) * scale} #{current_y * scale}"
      current_x += 1
      current_y -= 1
      direction = "UP"
    # We continue RIGHT
    elsif (current_x + 1 < width && grid[current_y][current_x + 1] == '#')
      current_x += 1
    # Switching DOWN
    else
      edges << "#{(current_x + 1) * scale} #{current_y * scale}"
      direction = "DOWN"
    end
  elsif direction == "DOWN"
    # Switching RIGHT
    if (current_y + 1 < height && current_x + 1 < width && grid[current_y + 1][current_x + 1] == '#')
      edges << "#{(current_x + 1) * scale} #{(current_y + 1) * scale}"
      current_x += 1
      current_y += 1
      direction = "RIGHT"
    # We continue DOWN
    elsif (current_y + 1 < height && grid[current_y + 1][current_x] == '#')
      current_y += 1
    # Switching LEFT
    else
      edges << "#{(current_x + 1) * scale} #{(current_y + 1) * scale}"
      direction = "LEFT"
    end
  elsif direction == "LEFT"
    # Switching DOWN
    if (current_y + 1 < height && current_x - 1 >= 0 && grid[current_y + 1][current_x - 1] == '#')
      edges << "#{current_x * scale} #{(current_y + 1) * scale}"
      current_x -= 1
      current_y += 1
      direction = "DOWN"
    # Continue LEFT
    elsif (current_x - 1 >= 0 && grid[current_y][current_x - 1] == '#')
      current_x -= 1
    # Switching UP
    else
      edges << "#{current_x * scale} #{(current_y + 1) * scale}"
      direction = "UP"
    end
  elsif direction == "UP"
    # Switching LEFT
    if (current_y - 1 >= 0 && current_x - 1 >= 0 && grid[current_y - 1][current_x - 1] == '#')
      edges << "#{current_x * scale} #{current_y * scale}"
      current_x -= 1
      current_y -= 1
      direction = "LEFT"
    # Continue UP
    elsif (current_y - 1 >= 0 && grid[current_y - 1][current_x] == '#')
      current_y -= 1
    # Switching RIGHT
    else
      edges << "#{current_x * scale} #{current_y * scale}"
      direction = "RIGHT"
    end
  end
end

edges.pop()  # The first edge is present twice, we drop the second one

puts edges.join("\n")