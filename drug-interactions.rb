require 'set'

#ttt = Time.now
word_frequencies = []
number_of_words = gets.to_i
h_matrix = Array.new(number_of_words) { Array.new(number_of_words, false) }
h_list = Array.new(number_of_words) { [] }

(0...number_of_words).each do |index|
  word_frequencies << Array.new(256, 0)
  gets.chomp.downcase.chars.each do |char|
    word_frequencies[index][char.ord] += 1
  end
  h_list[index] << index
  (0...index).each do |prev_index|
    count = 0
    (0...256).each do |k|
      if word_frequencies[index][k] > 0 && word_frequencies[prev_index][k] > 0
        count += [word_frequencies[index][k], word_frequencies[prev_index][k]].min
      end
    end
    if count < 3
      h_matrix[prev_index][index] = true
      h_list[prev_index] << index
    end
  end
end

max_count = 0

def solve(accumulator, words, h_matrix, max_count)
  index = accumulator[-1]
  possible_words = []

  words.each do |word|
    possible_words << word if h_matrix[index][word]
  end

  if possible_words.empty? || accumulator.length + possible_words.length < max_count
    max_count = [accumulator.length, max_count].max
    return max_count
  end

  until possible_words.empty?
    new_accumulator = accumulator.dup
    new_accumulator << possible_words.shift
    max_count = solve(new_accumulator, possible_words, h_matrix, max_count)
  end

  max_count
end

(0...number_of_words).each do |i|
  max_count = solve([i], h_list[i], h_matrix, max_count)
end

puts max_count