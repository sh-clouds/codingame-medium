def check_speed(current_car, car_name, kilometers_traveled, time_stamp)
  kilometers = kilometers_traveled - current_car[:km]
  hours = (time_stamp - current_car[:timestamp]) / 3600.0
  speed = kilometers / hours
  return speed
end

L_MAX = 100
L_MIN = 10
N_MAX = 100
C_MAX = 1000

length_limit = gets.to_i
number_of_cars = gets.to_i
cars = {}
is_speeding = true

number_of_cars.times do
  car_name, kilometers, time_stamp = gets.split
  current_car = cars[car_name]
  if current_car != nil
    speed = check_speed(current_car, car_name, kilometers.to_i, time_stamp.to_i)
    if speed > length_limit
      puts "#{car_name} #{kilometers}"
      is_speeding = false
    end
  end
  cars[car_name] = { car: car_name, km: kilometers.to_i, timestamp: time_stamp.to_i }
end

puts "OK" if is_speeding
