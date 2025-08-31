width = 0
alignment = gets.chomp

N = gets.to_i
text = []
N.times do
  text << gets.chomp
  width = [width, text.last.length].max
end

# Add pad on the left
if alignment == "RIGHT"
  text.each_with_index do |line, index|
    text[index] = line.rjust(width)
  end
# Add pad on both side  
elsif alignment == "CENTER"
  text.each_with_index do |line, index|
    text[index] = line.center(width).rstrip
  end
# Add pad between words 
elsif alignment == "JUSTIFY"
  text.each_with_index do |line, index|
    space = (width - line.length) / (line.split.size - 1) rescue 0 # The amount of space to add between 2 words
    justify = ""
    previous = 0

    line.split.each_with_index do |word, i|
      if i > 0
        extra_space = (space * i).round - previous # The amount of space to add before this word
        previous += extra_space
        justify += ' ' * (extra_space + 1)
      end

      justify += word
    end

    text[index] = justify
  end
end

puts text.join("\n")