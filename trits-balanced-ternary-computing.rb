def f(n, t)
  r = n % 3
  n = n / 3 + (r == 2 ? 1 : 0)
  f(n, t) if n != 0
  print t[r]
end

def tri_to_int(tri)
  res = 0
  tri.each_char do |c|
    case c
    when '1' then res = 3 * res + 1
    when '0' then res = 3 * res + 0
    when 'T' then res = 3 * res - 1
    end
  end
  res
end

l = gets.chomp
op = gets.chomp
r = gets.chomp
a = tri_to_int(l)
b = tri_to_int(r)
case op[0]
when '<' then b.times { a *= 3 }
when '>' then b.times { a /= 3 }
when '*' then a *= b
when '+' then a += b
when '-' then a -= b
end
if a >= 0
  f(a, "01T")
else
  f(-a, "0T1")
end
