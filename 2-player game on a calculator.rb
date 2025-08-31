possible_moves = {
  1 => [2, 4, 5],
  2 => [1, 3, 4, 5, 6],
  3 => [2, 5, 6],
  4 => [1, 2, 5, 7, 8],
  5 => [1, 2, 3, 4, 6, 7, 8, 9],
  6 => [2, 3, 5, 8, 9],
  7 => [4, 5, 8],
  8 => [4, 5, 6, 7, 9],
  9 => [5, 6, 8]
}

number_of_rounds = gets.to_i
minimum_moves = [9, number_of_rounds].min
rounds = Array.new(number_of_rounds + 1) { Array.new(minimum_moves + 1, false) }

(0..number_of_rounds).each do |round|
  (1..minimum_moves).each do |number|
    if round < number
      win = false
    else
      win = true
      possible_moves[number].each do |next_move|
        next if next_move > minimum_moves
        win &&= !rounds[round - number][next_move]
      end
    end
    rounds[round][number] = win
  end
end

puts rounds[number_of_rounds].each_index.select { |index| rounds[number_of_rounds][index] }.join(' ')