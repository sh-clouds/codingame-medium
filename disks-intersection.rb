def calculate_distance(x1, x2, y1, y2)
  Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
end

inputs = gets.chomp.split(" ")
x1 = inputs[0].to_i
y1 = inputs[1].to_i
r1 = inputs[2].to_i
inputs = gets.chomp.split(" ")
x2 = inputs[0].to_i
y2 = inputs[1].to_i
r2 = inputs[2].to_i

distance = calculate_distance(x1, x2, y1, y2)

if distance >= r1 + r2
  puts "0.00"
elsif distance < (r1 - r2).abs
  puts format('%.2f', Math::PI * [r1, r2].min**2)
else
  a = (r1**2 - r2**2 + distance**2) / (2 * distance)
  a_neg = distance - a
  height = Math.sqrt(r1**2 - a**2)

  area1 = r1**2 * Math.acos(a / r1) - a * height
  area2 = r2**2 * Math.acos(a_neg / r2) - a_neg * height

  puts format('%.2f', area1 + area2)
end
