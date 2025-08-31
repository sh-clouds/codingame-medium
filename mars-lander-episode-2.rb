STDOUT.sync = true # DO NOT REMOVE

number_of_landing_points = 0 # Number of landing points
position_x, position_y = 0, 0 # Position components
landing_coordinate_x, landing_coordinate_y = 0, 0 # Landing coordinates
speed_x, speed_y = 0, 0 # Speed components
fuel_level = 0 # Remaining fuel level
rocket_power = 0 # Power of the rockets
rotation_angle = 0 # Rotation angle of Mars Lander

# -- Compute the landing position -- #
last_landing_x, last_landing_y = 0, 0
number_of_landing_points = gets.to_i
number_of_landing_points.times do
  position_x, position_y = gets.split.map(&:to_i)

  if position_y == last_landing_y
    landing_coordinate_x = (last_landing_x + position_x) / 2
    landing_coordinate_y = last_landing_y
  end
  last_landing_x = position_x
  last_landing_y = position_y
end

# -- Play the game -- #
loop do
  position_x, position_y, speed_x, speed_y, fuel_level, rotation_angle, rocket_power = gets.split.map(&:to_i)

  rotation_angle = (position_y - landing_coordinate_y > 100) ? ((position_x - landing_coordinate_x) / 100 + speed_x * 0.64).to_i : 0
  rocket_power = (speed_y < -20 || speed_x**2 > 1600) ? 4 : 2

  puts "#{rotation_angle} #{rocket_power}"
end
