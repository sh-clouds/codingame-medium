require 'set'

DIRECTIONS = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]
INFINITY = Float::INFINITY
xmin, xmax, ymin, ymax = INFINITY, -INFINITY, INFINITY, -INFINITY
grid = {}
y, x = 0, 0
direction = DIRECTIONS[0]
string = "#"
index = 0
pen_down = true
default_char = " "

def replace(match)
  # Replaces RP X [c1;c2;...;cn] 
  # with c1;c2;...;cn;c1;c2..;cn ... X times
  _, times = match[1].strip.split
  Array.new(times.to_i) { match[2] }.join(";")
end

parsed_commands = []
gets.to_i.times do
  line = gets.strip
  if line.include?("[") # Parses the loops
    previous_line = nil
    while previous_line != line
      previous_line = line
      line = line.gsub(/([^;\[]+)\[([^\[\]]+)\]/) { |match| replace(Regexp.last_match) }
    end
  end
  parsed_commands.concat(line.split(";"))
end

parsed_commands.each do |command|
  begin
    _, b = command.split
  rescue
  ensure
    command = command.upcase
  end

  case command
  when /SETPC/
    string = b
    index = 0
  when /PD/
    pen_down = true
  when /PU/
    pen_down = false
  when /RT/
    direction = DIRECTIONS[(DIRECTIONS.index(direction) + b.to_i / 45) % 8]
  when /LT/
    direction = DIRECTIONS[(DIRECTIONS.index(direction) - b.to_i / 45) % 8]
  when /CS/
    default_char = b
  when /FD/
    b.to_i.times do
      if pen_down
        grid[[y, x]] = string[index % string.length]
        index += 1
      end
      xmax = [x, xmax].max
      xmin = [x, xmin].min
      ymax = [y, ymax].max
      ymin = [y, ymin].min
      y += direction[0]
      x += direction[1]
    end
  end
end

(ymin..ymax).each do |row_y|
  row = (xmin..xmax).map { |col_x| grid[[row_y, col_x]] || default_char }.join("")
  puts row.rstrip
end