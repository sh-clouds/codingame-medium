# Get required inputs.
width, height = gets.chomp.split.map(&:to_i)
number_of_bombs = gets.chomp
x_coordinate, y_coordinate = gets.chomp.split.map(&:to_i)

# Set variables for binary search.
left_x_limit = 0
right_x_limit = width - 1
top_y_limit = 0
bottom_y_limit = height - 1

# Complete binary search until bomb is found (Game engine decides when to stop not code)
loop do
    # Get bomb direction
    bomb_direction = gets.chomp

    # Move binary search limits based on the input.
    # (4 linear searches are fine here as bomb_direction has max len of 2)
    if bomb_direction.include?("U")
        bottom_y_limit = y_coordinate - 1
    end

    if bomb_direction.include?("D")
        top_y_limit = y_coordinate + 1
    end

    if bomb_direction.include?("L")
        right_x_limit = x_coordinate - 1
    end

    if bomb_direction.include?("R")
        left_x_limit = x_coordinate + 1
    end

    # Change values of x and y (Binary search)
    x_coordinate = (left_x_limit + right_x_limit) / 2
    y_coordinate = (top_y_limit + bottom_y_limit) / 2

    # Output the new coordinates.
    puts "#{x_coordinate} #{y_coordinate}"
end