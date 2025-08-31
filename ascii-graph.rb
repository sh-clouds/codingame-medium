# Read the number of points from standard input
number_of_points = gets.to_i

points = {}
x_coordinates = []
y_coordinates = []

# Read the points from standard input
number_of_points.times do
  x, y = gets.split.map(&:to_i)
  x_coordinates << x
  y_coordinates << y
  points["#{x}-#{y}"] = 1
end

# Determine the boundaries of the map
if number_of_points != 0
  minimum_x = [0, x_coordinates.min].min - 1
  maximum_x = [0, x_coordinates.max].max + 1
  minimum_y = [0, y_coordinates.min].min - 1
  maximum_y = [0, y_coordinates.max].max + 1
else
  minimum_x = minimum_y = -1
  maximum_x = maximum_y = 1
end

# In this case y is decreasing when going down the axis not increasing
map = []

(maximum_y).downto(minimum_y) do |current_y|
  line = ""

  # Set the character for this position
  (minimum_x..maximum_x).each do |current_x|
    if points.key?("#{current_x}-#{current_y}")
      character = "*"
    elsif current_x == 0 && current_y == 0
      character = "+"
    elsif current_y == 0
      character = "-"
    elsif current_x == 0
      character = "|"
    else
      character = "."
    end

    line += character
  end

  map << line
end

puts map.join("\n")