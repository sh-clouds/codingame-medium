
# Read input
number_of_groups = gets.to_i
groups = gets.chomp.split

top = Array.new(10, 'D')
bottom = Array.new(10, 'D')
position = 0
ride_number = 1
with_me = false

groups.each do |group|
  adults = group.count('A')
  next if group.length > adults * 2 || group.length > 20
  
  if group.length > (10 - position) * 2
    if with_me
      puts ride_number
      puts "/< | " + top.join(' | ') + " |"
      puts "\\< | " + bottom.join(' | ') + " |"
      exit
    end
    ride_number += 1
    top = Array.new(10, 'D')
    bottom = Array.new(10, 'D')
    position = 0
  end
  
  kids = group.length - adults
  if group.include?('x')
    with_me = true
    top[position] = 'A'
    bottom[position] = 'x'
    position += 1
    adults -= 1
    kids -= 1
  end
  
  kids.times do
    top[position] = 'A'
    bottom[position] = 'k'
    position += 1
  end
  
  ((adults - kids) / 2).times do
    top[position] = 'A'
    bottom[position] = 'A'
    position += 1
  end
  
  top[position] = 'A' if (adults - kids) % 2 != 0
  position += 1 if (adults - kids) % 2 != 0
end

puts ride_number
puts "/< | " + top.join(' | ') + " |"
puts "\\< | " + bottom.join(' | ') + " |"