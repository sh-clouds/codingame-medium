# Read integer input from standard input
number_of_lines = gets.to_i

# Initialize an array to hold the lines
lines = []

# Read each line from standard input
number_of_lines.times do
  lines << gets.chomp
end

# Remove the statement "S" and join the lines into a single string
line = lines.join(" ").gsub("S", "") # We don't care about the Statement, remove them

# Process the line to evaluate conditions
while line =~ /( if([ \d]+)else([ \d]+)endif)/
  # The number of result combinations in the 'then' part
  left_side = $2.split.map(&:to_i).reject(&:zero?).reduce(1, :*)
  # The number of result combinations in the 'else' part
  right_side = $3.split.map(&:to_i).reject(&:zero?).reduce(1, :*)

  # Replace the if else endif part with the number of combinations
  line.sub!($1, " #{left_side + right_side}")
end

# Took care of all the if statements, just do the product of the remaining values
if line =~ /begin(.*)end/
  puts $1.split.map(&:to_i).reject(&:zero?).reduce(1, :*)
end