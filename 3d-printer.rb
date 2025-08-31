width = gets.chomp.to_i
height = gets.chomp.to_i
length = gets.chomp.to_i

fline = []
height.times do
  fline << gets.chomp.ljust(width)
end

rline = []
height.times do
  rline << gets.chomp.reverse.ljust(length)
end

tline = []
length.times do
  tline << gets.chomp.ljust(width)
end

(height - 1).downto(0) do |i|
  length.times do |k|
    output_string = ""
    width.times do |j|
      if rline[i][k] == " "
        output_string += " "
      elsif fline[i][j] == " "
        output_string += " "
      elsif tline[k][j] == " "
        output_string += " "
      else
        output_string += "#"
      end
    end
    puts output_string.rstrip
  end
  puts "--"
end