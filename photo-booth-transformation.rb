def gcd(a, b)
  b != 0 ? gcd(b, a % b) : a
end

def lcm(a, b)
  a * b / gcd(a, b)
end

def find_period(size)
  history = {}

  return history[size] if history.key?(size)

  start = transformation = (1..size).to_a
  steps = 0

  loop do
    new_transformation = []

    # Apply the transformation
    (0...size).step(2) { |i| new_transformation << transformation[i] }
    (1...size).step(2) { |i| new_transformation << transformation[i] }

    transformation = new_transformation
    steps += 1

    break if transformation == start # We are back to the initial array, we have found the period
  end

  history[size] = steps
end

t = gets.to_i
t.times do
  w, h = gets.split.map(&:to_i)

  # Sizes are independent, the answer is the LCM of both periods
  puts lcm(find_period(w), find_period(h))
end
