STDOUT.sync = true # DO NOT REMOVE

# Don't let the machines win. You are humanity's last hope...
width = gets.to_i  # the number of cells on the X axis
height = gets.to_i  # the number of cells on the Y axis
lines = []
(0...height).each do |i|
    line = gets.chomp  # width characters, each either 0 or .
    lines << line.chars
end
(0...height).each do |y|
    (0...width).each do |x|
       next if lines[y][x] == "."
       right_x = right_y = bottom_x = bottom_y = -1
       begin
           (x + 1...width).each do |tx|
               if lines[y][tx] == '0'
                   right_x = tx
                   right_y = y
                   break
               end
           end
       rescue StandardError
           # Ignored
       end
       begin
           (y + 1...height).each do |ty|
               if lines[ty][x] == '0'
                   bottom_x = x
                   bottom_y = ty
                   break
               end
           end
       rescue StandardError
           # Ignored
       end
       puts "#{x} #{y} #{right_x} #{right_y} #{bottom_x} #{bottom_y}"
    end
end
