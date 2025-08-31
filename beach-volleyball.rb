start_x, start_y = gets.split.map(&:to_i)
beach_y = gets.to_i
ball_x, ball_y = gets.split.map(&:to_i)
speed_land = gets.to_i
speed_water = gets.to_i

# Calculate the distance between two points
def distance(x1, y1, x2, y2)
  Math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
end

# time from start to ball
def time_to_reach_ball(beach_x, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water)
  distance(ball_x, ball_y, beach_x, beach_y) * speed_land + distance(start_x, start_y, beach_x, beach_y) * speed_water
end

a, d = 0, 20000000

while d - a > 2  # 2/3 split
  b = (a + (d - a) * 1 / 3).to_i
  c = (a + (d - a) * 2 / 3).to_i

  min_time = [time_to_reach_ball(a, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water), 
              time_to_reach_ball(b, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water), 
              time_to_reach_ball(c, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water), 
              time_to_reach_ball(d, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water)].min

  if min_time == time_to_reach_ball(a, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water) || 
     min_time == time_to_reach_ball(b, ball_x, ball_y, beach_y, speed_land, start_x, start_y, speed_water)
    d = c
  else
    a = b
  end
end

puts a + 1