m = gets.to_i
n = gets.to_i
map = []
m.times do
  map << gets.chomp
end

memorization = {}
memorization["0 0"] = 1

def solve(x, y, map, memorization)
  # Use saved value
  return memorization["#{x} #{y}"] if memorization.key?("#{x} #{y}")

  # We can't come from this position
  return 0 if x < 0 || y < 0 || map[y][x] == '1'
  
  # We can only come from top or left, the number of path is the sum
  result = solve(x, y - 1, map, memorization) + solve(x - 1, y, map, memorization)

  # Save the value for later
  memorization["#{x} #{y}"] = result
  result
end

puts solve(m - 1, n - 1, map, memorization)