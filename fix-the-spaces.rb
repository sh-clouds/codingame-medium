original_string = gets.chomp || '0'
words_array = gets.chomp.split(' ') || ['0']
lengths_array = words_array.map(&:length)
min_length = lengths_array.min
max_length = lengths_array.max
available_words = Hash.new(0)
words_array.each do |word|
  available_words[word] += 1
end

queue = [[0, [0], {}]]
read_index = 0
answer_string = ''
loop do
  if read_index == queue.length
    answer_string = 'Unsolvable' if answer_string.empty?
    break
  end
  position, spaces_array, used_words_hash = queue[read_index]
  read_index += 1
  if position == original_string.length && spaces_array.length == words_array.length + 1
    if !answer_string.empty?
      answer_string = 'Unsolvable'
      break
    end
    (1...spaces_array.length).each do |i|
      answer_string += ' ' if i > 1
      answer_string += original_string[spaces_array[i - 1]...spaces_array[i]]
    end
    next
  end
  next if position > original_string.length
  next if spaces_array.length >= words_array.length + 1

  (min_length..max_length).each do |length|
    word_segment = original_string[position, length]
    next unless available_words.key?(word_segment)
    next if (used_words_hash[word_segment] || 0) >= available_words[word_segment]

    new_position = position + length
    new_spaces = spaces_array.dup << new_position
    new_used_words = used_words_hash.dup
    new_used_words[word_segment] = (new_used_words[word_segment] || 0) + 1
    queue << [new_position, new_spaces, new_used_words]
  end
end

puts answer_string