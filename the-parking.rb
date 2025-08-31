require 'time'
# Constants
CAR_SPOTS = 7
CAR_RATE = 1.2
MOTO_SPOTS = 2
MOTO_RATE = 0.7
FULL_DAY = 30

cars = {}
motos = {}
refused_cars = 0
refused_motos = 0
fees = 0.0

H = gets.to_i

H.times do
  inputs = gets.strip.split(" ")
  count = inputs.length

  # Vehicles are arriving
  if inputs[1] == '>'
    (2...count).each do |i|
      if inputs[i][0] == 'C'
        # No spots left for cars
        if cars.length == CAR_SPOTS
          refused_cars += 1
        else
          cars[inputs[i]] = DateTime.parse(inputs[0])
        end
      else
        # No spots left for motos
        if motos.length == MOTO_SPOTS
          refused_motos += 1
        else
          motos[inputs[i]] = DateTime.parse(inputs[0])
        end
      end
    end
  # Vehicles are leaving
  else
    (2...count).each do |i|
      if inputs[i][0] == 'C'
        diff = (DateTime.parse(inputs[0]) - cars[inputs[i]]).to_f * 24 * 60
        diff_in_minutes = diff.to_i

        if diff_in_minutes >= 30
          fees += CAR_RATE * ((diff_in_minutes / 15.0).ceil)
        end

        cars.delete(inputs[i])
      else
        diff = (DateTime.parse(inputs[0]) - motos[inputs[i]]).to_f * 24 * 60
        diff_in_minutes = diff.to_i

        if diff_in_minutes >= 30
          fees += MOTO_RATE * ((diff_in_minutes / 15.0).ceil)
        end

        motos.delete(inputs[i])
      end
    end
  end
end

# Add the fees for the vehicles present at the end of the day
fees += cars.length * FULL_DAY + motos.length * FULL_DAY

puts format('%.1f %d %d', fees, refused_cars, refused_motos)