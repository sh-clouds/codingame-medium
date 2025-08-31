def get_factors(number)
  factors = []
  factors << number if number != 1
  (2..Math.sqrt(number).to_i).each do |i|
    if number % i == 0
      factors << i
      factors << number / i
    end
  end
  factors
end

def simplify_function(numerator, denominator)
  temp_numerator = numerator
  temp_denominator = denominator
  if temp_numerator == temp_denominator
    numerator = 1
    denominator = 1
    return numerator, denominator
  elsif temp_numerator == -temp_denominator
    numerator = -1
    denominator = 1
    return numerator, denominator
  elsif temp_numerator == 0
    denominator = 1
    return numerator, denominator
  end

  smallest = [temp_numerator.abs, temp_denominator.abs].min

  factors = get_factors(smallest)
  factors.each do |factor|
    while temp_numerator % factor == 0 && temp_denominator % factor == 0
      temp_numerator /= factor
      temp_denominator /= factor
    end
  end
  return temp_numerator, temp_denominator
end

def binomial_coefficient(n, k)
  n -= k
  coefficient = 1
  (1..k).each do |i|
    coefficient = coefficient * (n + i) / i
  end
  coefficient.to_i
end

n = gets.to_i
w = gets.to_i
s = gets.to_i
k = gets.to_i

numerator = binomial_coefficient(w, k) * binomial_coefficient(n - w, s - k)
denominator = binomial_coefficient(n, s)
numerator, denominator = simplify_function(numerator, denominator)

if numerator == denominator
  puts "1:0"
else
  puts "#{numerator}:#{denominator - numerator}"
end