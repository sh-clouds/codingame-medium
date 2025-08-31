require 'set'

number_of_pegs = gets.to_i
#pegs = Array.new(number_of_pegs) { gets.split.map(&:to_i) }
pegs = Set.new
number_of_pegs.times do
  x, y = gets.split
  pegs.add([x.to_i, y.to_i])
end

#for all pair of points a,b
#find vector v = a -> b
#search for c = a + -1/v
#if so search d = c + v; count+=1
#each square is counted for each line in square
#thus count /= 4 at end

#this method builds a clockwise C of three sides
#for each square, there are two sides ab with xb >= xa, yb > ya
#only one with clockwise C

count = 0
pegs.each do |a|
  pegs.each do |b|
    if a[0] <= b[0] && a[1] < b[1]
      vector = [b[0] - a[0], b[1] - a[1]]
      c = [a[0] - vector[1], a[1] + vector[0]]
      if pegs.include?(c)
        if pegs.include?([c[0] + vector[0], c[1] + vector[1]])
          count += 1
        end
      end
    end
  end
end
puts count