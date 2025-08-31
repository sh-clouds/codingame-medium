initial_number = gets.to_i
length = gets.to_i
sequence_array = [initial_number]

(1...length).each do
  new_sequence_array = []
  count = 0
  last_number = -1
  
  sequence_array.each do |current_number|
    if current_number != last_number
      if count != 0
        new_sequence_array << count
        new_sequence_array << last_number
      end
      count = 1
    else
      count += 1
    end
    last_number = current_number
  end
  
  new_sequence_array << count
  new_sequence_array << last_number
  sequence_array = new_sequence_array
end

puts sequence_array.join(' ')