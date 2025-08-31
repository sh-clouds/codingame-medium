def find_letters(phrase, nth)
  positions = []
  letters = []

  phrase.chars.each_with_index do |char, index|
    next unless char =~ /[A-Za-z]/
    if (char.ord - 64) % nth == 0
      positions << index
      letters << char
    end
  end

  [positions, letters]
end

phrase = $stdin.gets.chomp

# Count the number of letters in each word
words = phrase.split(" ").map(&:length)

# Reverse that list of numbers
words.reverse!

phrase.gsub!(" ", "")
offset = 0

# Re-apply the revised word lengths to the letter sequence.
words.each do |size|
  phrase = phrase[0, size + offset] + " " + phrase[size + offset..-1]
  offset += size + 1
end

phrase.strip!

# Find every 4th letter of the alphabet in the phrase
positions, letters = find_letters(phrase, 4)

# Reverse shift their positions one to the left
letters.unshift(letters.pop)

positions.each_with_index do |position, index|
  phrase[position] = letters[index]
end

# Find every 3rd letter of the alphabet in the phrase
positions, letters = find_letters(phrase, 3)

# Reverse shift their positions one to the right
letters << letters.shift

positions.each_with_index do |position, index|
  phrase[position] = letters[index]
end

# Find every 2nd letter of the alphabet in the phrase
positions, letters = find_letters(phrase, 2)

# Reverse their order 
letters.reverse!

positions.each_with_index do |position, index|
  phrase[position] = letters[index]
end

puts phrase