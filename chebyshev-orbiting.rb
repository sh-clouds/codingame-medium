radius, x, y, velocity_x, velocity_y, time = gets.strip.split.map(&:to_i)

history = {}

while time > 0
  time -= 1
  if !history.key?("#{x} #{y} #{velocity_x} #{velocity_y}")
    history["#{x} #{y} #{velocity_x} #{velocity_y}"] = "#{x} #{y} 0"
  else
    puts history.values[(time % history.size) + 1]
    exit
  end

  # Update spaceship coordinate
  x += velocity_x
  y += velocity_y

  # Update velocity
  if x > 0
    velocity_x -= 1
  elsif x < 0
    velocity_x += 1
  end
  if y > 0
    velocity_y -= 1
  elsif y < 0
    velocity_y += 1
  end

  # Check if spaceship crashed
  if [x.abs, y.abs].max <= radius
    puts "#{x} #{y} 1"
    exit
  end
end

puts "#{x} #{y} 0"