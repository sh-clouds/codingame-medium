level = gets.to_i
xp = gets.to_i
N = gets.to_i

xp_gained = N * 300

loop do
  if xp <= xp_gained
    level += 1
    xp_gained -= xp
    xp = (level * Math.sqrt(level) * 10).floor
  else
    xp -= xp_gained
    break
  end
end

puts "#{level}\n#{xp}"