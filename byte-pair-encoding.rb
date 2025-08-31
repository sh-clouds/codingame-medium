# Read input values
n, m = gets.chomp.split.map(&:to_i)

line = ""
n.times do
  line += gets.chomp
end

def find_repetitive(input_string)
  repetitions = {}

  # Count the occurrence of all the byte pairs
  (0...input_string.length - 1).each do |i|
    pair = input_string[i, 2]

    unless repetitions.key?(pair)
      repetitions[pair] = input_string.scan(/#{Regexp.escape(pair)}/).count
    end
  end

  # It needs to be repeated at least twice
  repetitions.select! { |_, repetition| repetition > 1 }

  return "" if repetitions.empty? # No pair is repeating
  repetitions.key(repetitions.values.max) # We choose the first (leftmost) pair
end

rules = []
characters = ("A".."Z").to_a

loop do
  repetition = find_repetitive(line)

  # There are no repeated byte pairs, it's over
  break if repetition.empty?

  character = characters.pop

  line.gsub!(repetition, character)
  rules << "#{character} = #{repetition}"
end

puts line
puts rules.join("\n")