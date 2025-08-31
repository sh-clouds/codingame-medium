def cut(a, b)
  if a == b
    return 1
  end
  if b > a
    a, b = b, a
  end
  if $d[[a, b]]
    return $d[[a, b]]
  end
  min_value = a * b
  (1...a).each do |i|
    a1 = i
    a2 = a - i
    min_value = [min_value, cut(a1, b) + cut(a2, b)].min
  end
  (1...b).each do |i|
    b1 = i
    b2 = b - i
    min_value = [min_value, cut(a, b1) + cut(a, b2)].min
  end
  $d[[a, b]] = min_value    
  return min_value
end


a, b = gets.chomp.split.map(&:to_i)
$d = {}
puts cut(a, b)