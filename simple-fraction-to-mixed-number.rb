def find_irred(a, b)
  a1 = a
  b1 = b
  a_factors = []
  b_factors = []
  
  (2...a1).each do |i|
    while a % i == 0
      a_factors << i
      a /= i
    end
    break if a == 1
  end
  
  (2...b1).each do |i|
    while b % i == 0
      b_factors << i
      b /= i
    end
    break if b == 1
  end
  
  a_factors = [a1] if a_factors.empty?
  b_factors = [b1] if b_factors.empty?
  
  a_factors_copy = a_factors.dup
  a_factors_copy.each do |nb|
    if b_factors.include?(nb)
      a_factors.delete_at(a_factors.index(nb))
      b_factors.delete_at(b_factors.index(nb))
    end
  end
  
  [prod(a_factors), prod(b_factors)]
end

def prod(iterable)
  result = 1
  iterable.each { |x| result *= x }
  result
end

N = gets.to_i
N.times do
  xY = gets.strip
  x, y = xY.split('/').map(&:to_i)
  sign = ''
  
  if y == 0
    puts 'DIVISION BY ZERO'
  elsif x % y == 0
    puts x / y
  elsif x.abs < y.abs
    sign = '-' if x.to_f / y < 0
    x = x.abs
    y = y.abs
    res = find_irred(x, y)
    B = res[0]
    C = res[1]
    puts "#{sign}#{B}/#{C}"
  else
    sign = '-' if x.to_f / y < 0
    x = x.abs
    y = y.abs
    A = x / y
    x = x % y
    res = find_irred(x, y)
    B = res[0]
    C = res[1]
    puts "#{sign}#{A} #{B}/#{C}"
  end
end