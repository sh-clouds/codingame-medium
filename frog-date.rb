# Function to calculate GCD
def gcd(a, b)
  b == 0 ? a : gcd(b, a % b)
end

# Extended Euclidean Algorithm to find the modular inverse
def extended_gcd(a, b)
  return [a, 1, 0] if b == 0
  
  g, x1, y1 = extended_gcd(b, a % b)

  x = y1
  y = x1 - (a / b) * y1

  [g, x, y]
end

x, y, m, n, L = gets.chomp.split.map(&:to_i)

if m == n
  print("Impossible") # Both frogs move at the same speed, it's impossible 
  exit
end

# After k jumps, the position of Frog A will be: (x + k * m) mod L
# After k jumps, the position of Frog B will be: (y + k * n) mod L
# For frogs to meet we need to have: (x + k * m) ≡ (y + k * n) mod L
# Or: k * (m − n) ≡ (y − x) mod L

jump_diff = m - n
position_diff = (y - x) % L

# Calculate gcd of (m - n) and L
gcd_value = gcd(jump_diff, L)

# Check if gcd divides the position difference
if position_diff % gcd_value != 0
  exit("Impossible")
end

# Normalize the values
L /= gcd_value
jump_diff /= gcd_value
position_diff /= gcd_value

# Get gcd, modular inverse (x), and y from the extended Euclidean algorithm
_, mod_inv, _ = extended_gcd(jump_diff, L)

# Find the smallest positive k
k = (position_diff * mod_inv) % L

# We need the first non-negative value
k += L.abs if k < 0

puts k
