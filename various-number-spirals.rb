DIRECTION = [[1, 0], [0, 1], [-1, 0], [0, -1]]

n = gets.to_i
vertical_position, horizontal_position = gets.split
order, direction_choice = gets.split

spiral = Array.new(n) { Array.new(n, 0) }

# The starting point and the starting direction
if vertical_position == "t" && horizontal_position == "l"
  x = 0
  y = 0
  direction = 0
elsif vertical_position == "t" && horizontal_position == "r"
  x = n - 1
  y = 0
  direction = 1
elsif vertical_position == "b" && horizontal_position == "r"
  x = n - 1
  y = n - 1
  direction = 2
elsif vertical_position == "b" && horizontal_position == "l"
  x = 0
  y = n - 1
  direction = 3
end

# We are going counter-clockwise
if direction_choice != "c"
  direction = (direction + 1) % 4
end

numbers = order == "+" ? (n**2).downto(1).to_a : (1..n**2).to_a

loop do
  spiral[y][x] = numbers.pop

  break if numbers.empty?

  # If we are leaving the spiral or reaching an already set number we need to change direction
  if (0 <= y + DIRECTION[direction][1] && y + DIRECTION[direction][1] < n && 
      0 <= x + DIRECTION[direction][0] && x + DIRECTION[direction][0] < n &&
      spiral[y + DIRECTION[direction][1]][x + DIRECTION[direction][0]] == 0)
  else
    direction = (direction + (direction_choice == "c" ? 1 : -1) + 4) % 4
  end

  x += DIRECTION[direction][0]
  y += DIRECTION[direction][1]
end

puts spiral.map { |line| line.join("\t") }.join("\n")