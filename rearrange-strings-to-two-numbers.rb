# include necessary libraries
require 'set'

def is_nb(vector)
  length = vector.sum
  return (!vector.any? { |i| i < 0 } && length) && 
         ((length == 1) || (length == 19 && vector[0] == 18 && vector[1] == 1) || (length < 19 && vector[0] < length))
end

def to_nb(vector)
  result = ""
  vector.fill(0, vector.length, 10)

  (1...vector.size).each do |i|
    if vector[i] > 0
      vector[i] -= 1
      result += (i + '0'.ord).chr
      break
    end
  end

  vector.each_with_index do |count, i|
    count.times do
      result += (i + '0'.ord).chr
    end
  end

  result
end

def test(a, b)
  b.each_with_index do |value, i|
    a[i] -= value
  end

  if is_nb(a)
    return true
  end

  b.each_with_index do |value, i|
    a[i] += value
  end

  false
end

# Main execution
s = gets.chomp
a = Array.new(10, 0)
b = Array.new(10, 0)

s.each_char do |c|
  a[c.ord - '0'.ord] += 1
end

if test(a, [1])
  puts "#{to_nb([1])} #{to_nb(a)}"
elsif test(a, [18, 1])
  puts "#{to_nb(a)} #{to_nb([18, 1])}"
else
  k = 18
  last = -1
  (9).downto(0) do |i|
    d = [k, a[i]].min
    last = i if d > 0 && i > 0
    a[i] -= d
    b[i] += d
    k -= d
  end

  if !is_nb(a) && last != -1
    a[last] += 1
    b[last] -= 1

    if a[0] > 0
      a[0] -= 1
      b[0] += 1
    end
  end

  if is_nb(a) && is_nb(b)
    puts "#{to_nb(a)} #{to_nb(b)}"
  else
    puts "-1 -1"
  end
end