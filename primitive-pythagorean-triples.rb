# PRIMITIVE PYTHAGOREAN TRIPLES
# https://mathworld.wolfram.com/PythagoreanTriple.html

def gcd(a, b)
  return a if b == 0
  gcd(b, a % b)
end

c_value = gets.to_i
c_sqrt = Math.sqrt(c_value).ceil
count = 0

(1...c_sqrt).each do |m|
(m + 1...c_sqrt).each do |n|
    if gcd(m, n) == 1 && (m + n).odd? && (m * m + n * n) <= c_value
    count += 1
    end
end
end
puts count