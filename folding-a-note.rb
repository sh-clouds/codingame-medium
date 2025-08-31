n = gets.to_i
p = Array.new(n) { gets.chomp.chars }

while p[0].length > 1
  temp = []
  p.each do |c|
    temp << (0...(c.length / 2)).map { |i| c[-(i + 1)].reverse + c[i] }
  end
  p = temp.transpose.reverse
end
puts p[0][0]
