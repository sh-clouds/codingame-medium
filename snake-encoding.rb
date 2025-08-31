s = []
n = gets.to_i
x = gets.to_i
n.times do
  s << gets.chomp.chars
end

x.times do
  tmp = (n % 2).zero? ? s[n - 1][n - 1] : s[0][n - 1] # head of a snake
  n.times do |j|
    if (j + 1).odd? # odd columns
      n.times.reverse_each do |k|
        tmp2 = s[k][j]
        s[k][j] = tmp
        tmp = tmp2
      end
    else
      n.times do |k| # even columns
        tmp2 = s[k][j]
        s[k][j] = tmp
        tmp = tmp2
      end
    end
  end
end

s.each do |line|
  puts line.join
end