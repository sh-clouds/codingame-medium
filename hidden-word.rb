require 'set'

n = gets.to_i
words = Array.new(n) { gets.chomp }
h, w = gets.chomp.split.map(&:to_i)
grid = Array.new(h) { gets.chomp }

lines = []
# Horizontal lines
(0...h).each do |i|
  lines << (0...w).map { |x| [x, i] }
end
# Vertical lines
(0...w).each do |i|
  lines << (0...h).map { |y| [i, y] }
end
# SW to NE diagonal lines
(0...(h + w - 1)).each do |i|
  lines << (0...w).map { |z| [z, i - z] if (0 <= i - z && i - z < h) }.compact
end
# NW to SE diagonal lines
(-w + 1...h).each do |i|
  lines << (0...w).map { |z| [z, i + z] if (0 <= i + z && i + z < h) }.compact
end
# Add all reverse directions
lines += lines.map(&:reverse)

struck_out = Set.new

lines.each do |line|
  letters = line.map { |x, y| grid[y][x] }.join
  words.each do |word|
    next unless letters.include?(word)

    start = letters.index(word)
    struck_out.merge(line[start, word.length])
  end
end

(0...h).each do |y|
  (0...w).each do |x|
    print grid[y][x] unless struck_out.include?([x, y])
  end
end