lines = []
answers = []

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

width, height = gets.split.map(&:to_i)
height.times do
  lines << gets.chomp
end

# Write an action using print
# To debug: puts "Debug messages..." if $DEBUG

def check_cell(x, y, height, width, lines)
  if x < 0 || x >= height || y < 0 || y >= width
    return 0
  else
    return lines[x][y].to_i
  end
end

height.times do |i|
  answers[i] = ""
  width.times do |j|
    this_cell = lines[i][j].to_i
    count_live = check_cell(i - 1, j - 1, height, width, lines) +
                 check_cell(i - 1, j, height, width, lines) +
                 check_cell(i - 1, j + 1, height, width, lines) +
                 check_cell(i, j - 1, height, width, lines) +
                 check_cell(i, j + 1, height, width, lines) +
                 check_cell(i + 1, j - 1, height, width, lines) +
                 check_cell(i + 1, j, height, width, lines) +
                 check_cell(i + 1, j + 1, height, width, lines)

    if this_cell == 0
      if count_live == 3
        answers[i] += "1"
      else
        answers[i] += "0"
      end
    else
      if count_live == 2 || count_live == 3
        answers[i] += "1"
      else
        answers[i] += "0"
      end
    end
  end
end

height.times do |i|
  puts answers[i]
end