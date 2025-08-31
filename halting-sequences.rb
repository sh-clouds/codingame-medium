def test(a, b)
  n = 1
  while n < 50
    return "halts" if a == b
    a, b = [ [a * 2, b - a].min, [a * 2, b - a].max ]
    n += 1
  end
  "loops"
end

n = gets.to_i
n.times do
  a, b = gets.split.map(&:to_i)
  puts test(a, b)
end
