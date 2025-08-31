def mod_inverse(a, m)
  m0 = m
  y = 0
  x = 1

  return 0 if m == 1

  while a > 1
    # q is quotient
    q = (a / m).to_i
    t = m

    # m is remainder now,
    # process same as
    # Euclid's algo
    m = a % m
    a = t
    t = y

    # Update y and x
    y = x - q * y
    x = t
  end

  # Make x positive
  x += m0 if x < 0

  x
end

a, c, m = gets.chomp.split.map(&:to_i)
seed = gets.chomp.to_i
steps = gets.chomp.to_i


# We consider that the LCG period is full, every m the values will start to repeat
# Find the lowest steps to find the value we want without timing out
s1 = steps % m

# Get the number of steps in the opposite direction
s2 = (s1 > 0) ? s1 - m : s1 + m

steps = (s1.abs < s2.abs) ? s1 : s2

=begin
 * https://www.nayuki.io/page/fast-skipping-in-a-linear-congruential-generator
 * Backward iteration
 * a-1 is the multiplicative inverse of a
 * a => (a−1 mod m)
 * c => (−(a−1 * c) mod m)
=end

if steps < 0
  inverse = mod_inverse(a, m)
  a = inverse
  c = inverse * -c
  steps = -steps
end

=begin
 * https://www.nayuki.io/page/fast-skipping-in-a-linear-congruential-generator
 * Fast skipping
 * xn = [( (a^n * x0) mod m) + ( ( ( (a^n −1) mod ((a−1) * m) ) / a−1) * b)] mod m.
=end

# a^n might be very high, we use the fact that (x * y) mod z = ((x mod z) * y) mod z
t1 = 1
steps.times do
  t1 = (t1 * a) % m
end # a^n mod m

t2 = t1 * seed # a^n * x0
t3 = t2 % m   # (a^n * x0) mod m

t4 = m * (a - 1) # m (a - 1)

t5 = 1
steps.times do
  t5 = (t5 * a) % t4
end # a^n mod (m (a - 1))

t6 = t5 / (a - 1) # ( (a^n −1) mod ((a−1) * m) ) / a−1
t7 = t6 * c # ( ( ( (a^n−1) mod ((a−1) * m) ) / a−1) * b

t8 = t3 + t7
t9 = t8 % m

# Make sure seed is always > 0
t10 = (t9 + m) % m

puts t10
