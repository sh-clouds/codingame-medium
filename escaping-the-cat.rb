STDOUT.sync = true # DO NOT REMOVE


cat_speed = gets.to_i
mouse_speed = 10.0
radius = 500.0
pi = Math::PI
circumference = 2.0 * radius * pi
cat_speed = cat_speed / circumference
circumference = mouse_speed / cat_speed
radius_mouse = circumference / 2.0 / pi
ratio = (radius_mouse - 5.0) / radius
escaping = false
dist_to_escape = 0.0

loop do
  mouse_x, mouse_y, cat_x, cat_y = gets.split.map(&:to_i)
  point_x = (-cat_x * ratio).floor
  point_y = (-cat_y * ratio).floor

  if escaping
    puts "#{(mouse_x * 2.0).ceil} #{(mouse_y * 2.0).ceil}"
  else
    puts "#{point_x} #{point_y}"
  end
  
  dist_to_escape = Math.sqrt((point_x - mouse_x)**2 + (point_y - mouse_y)**2)
          
  if ratio < 0.5
    if dist_to_escape < 10.0
      escaping = true
    end
  else
    if dist_to_escape < 80.0
      escaping = true
    end
  end
end