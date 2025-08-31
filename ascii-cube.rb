w = gets.to_i
h = gets.to_i
d = gets.to_i

cube = Array.new(h + d + 1) { Array.new(d + w * 2 + h, " ") }

(0...w * 2).each do |i|
  cube[h][d + h + i] = '.'
end

(0...w * 2).each do |i|
  cube[0][d + i] = '_'
end

(1...w * 2).each do |i|
  cube[d][i] = '_'
end

(1..(w - 1) * 2).each do |i|
  cube[h + d][h + i] = '_'
end

(0...h).each do |i|
  cube[i + 1][d + i] = "⠡"
end

(0...d).each do |i|
  cube[h + d - i][h + i] = "⠌"
end

if w == 1
  cube[h + d][h] = '_'
  cube[1][d] = ' '
end

if h == 1
  cube[h + d][1] = '_'
end

if d == 1
  cube[1][1] = '_'
  cube[h][d + w * 2 + h - 2] = ' '
end

(0...h).each do |i|
  cube[i + 1][d + w * 2 + i] = "\\"
  cube[i + d + 1][i] = "\\"
  cube[i + d + 1][i + w * 2] = "\\"
end

(0...d).each do |i|
  cube[d - i][i] = "/"
  cube[d - i][w * 2 + i] = "/"
  cube[d - i + h][w * 2 + h + i] = "/"
end

puts cube.map { |line| line.join.rstrip }.join("\n")
