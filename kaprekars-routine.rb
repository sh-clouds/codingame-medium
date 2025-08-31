n = gets.strip
count = n.length
history = {}
index = 0

while true
  if history.key?(n)
    puts history.keys[history[n]..-1].join(" ")
    exit
  else
    history[n] = index
    index += 1
  end

  n = n.chars

  n.sort!

  dn = n.reverse.join
  an = n.join

  n = (dn.to_i - an.to_i).to_s.rjust(count, '0')
end
