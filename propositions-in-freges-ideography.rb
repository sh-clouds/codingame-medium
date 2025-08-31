# Import necessary libraries
require 'set'

lines = Array.new(gets.to_i) { gets.chomp }
letters = lines.map { |line| line[-1] }.to_set.to_a.sort

def is_set(letter, state, letters)
  letter_index = letters.length - 1 - letters.index(letter)
  (state >> letter_index & 1) == 1
end

def get(pos, lines)
  lines[pos[0]][pos[1]]
end

def evaluate(state, pos, lines, letters)
  char = get(pos, lines)
  if char == "+"
    return !evaluate(state, [pos[0], pos[1] + 1], lines, letters)
  elsif char == "'" || char == " "
    return evaluate(state, [pos[0], pos[1] + 1], lines, letters)
  elsif char == "|"
    return evaluate(state, [pos[0] + 1, pos[1]], lines, letters)
  elsif char == "-"
    if pos[0] + 1 < lines.length && get([pos[0] + 1, pos[1]], lines) =~ /[|']/ 
      return (!evaluate(state, [pos[0] + 1, pos[1]], lines, letters)) || evaluate(state, [pos[0], pos[1] + 1], lines, letters)
    else
      return evaluate(state, [pos[0], pos[1] + 1], lines, letters)
    end
  elsif letters.include?(char)
    return is_set(char, state, letters)
  end
end

def state_string(state, letters)
  letter_strings = []
  letters.each do |letter|
    letter_strings << "#{letter} #{is_set(letter, state, letters) ? 'True' : 'False'}"
  end
  letter_strings.join(" ")
end

falsifying = []

(0...(2**letters.length)).each do |i|
  if !evaluate(i, [0, 0], lines, letters)
    falsifying << state_string(i, letters)
  end
end

# Print results
if falsifying.empty?
  puts "TAUTOLOGY"
else
  falsifying.sort.each { |i| puts i }
end