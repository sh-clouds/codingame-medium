def gcd(a, b)
  return a if b.zero?
  gcd(b, a % b)
end

x_values = []
y_values = []
k_values = []

3.times do
  x_value, y_value, k_value = gets.split.map(&:to_i)
  x_values << x_value
  y_values << y_value
  k_values << k_value
end

# We want to check if we can solve:
# x1+n1⋅k1
# x2+n2⋅k2
# x3+n3⋅k3
# Such as x1+n1⋅k1 = x2+n2⋅k2 = x3+n3⋅k3
# 
# Which gives us:
# n1⋅k1−n2⋅k2 = x2−x1 => x2−x1 must be an integer multiple of k1 and k2 => $x2-x1 must be divisible by gcd(k1,k2)
# n2⋅k2−n3⋅k3 = x3−x2 => x3−x2 must be an integer multiple of k2 and k3 => $x3-x2 must be divisible by gcd(k2,k3)
# n3⋅k3−n1⋅k1 = x1−x3 => x1−x3 must be an integer multiple of k3 and k1 => $x1-x3 must be divisible by gcd(k3,k1)

gcd1 = gcd(k_values[0], k_values[1])
gcd2 = gcd(k_values[1], k_values[2])
gcd3 = gcd(k_values[2], k_values[0])

if ((x_values[1] - x_values[0]) % gcd1 == 0 && 
    (x_values[2] - x_values[1]) % gcd2 == 0 && 
    (x_values[0] - x_values[2]) % gcd3 == 0 && 
    (y_values[1] - y_values[0]) % gcd1 == 0 && 
    (y_values[2] - y_values[1]) % gcd2 == 0 && 
    (y_values[0] - y_values[2]) % gcd3 == 0)
  puts "Possible"
else
  puts "Impossible"
end