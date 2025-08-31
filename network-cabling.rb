n = gets.to_i

X_COORDS, Y_COORDS = [], []
n.times do
    x, y = gets.split.map(&:to_i)
    X_COORDS << x
    Y_COORDS << y
end

median = (Y_COORDS.sort)[n/2]

puts X_COORDS.max - X_COORDS.min + Y_COORDS.map { |y| (y - median).abs } .sum