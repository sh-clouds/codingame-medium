# Constants for removing possibilities based on number
REMOVE = { 1 => 510, 2 => 509, 3 => 507, 4 => 503, 5 => 495, 6 => 479, 7 => 447, 8 => 383, 9 => 255 }
VALUES = { 1 => 1, 2 => 2, 3 => 4, 4 => 8, 5 => 16, 6 => 32, 7 => 64, 8 => 128, 9 => 256 }

start_time = Time.now

grid = ""

9.times do
  grid += gets.chomp
end

possible_numbers = {}
relations = {}
position_to_find = {}

# First step we get all the possibilities for the numbers we have to find
(0...9).each do |y|
  (0...9).each do |x|
    index = y * 9 + x

    # This number is missing
    if grid[index] == "0"
      numbers = 511
      related = {}

      # Check row & column
      (0...9).each do |i|
        index_row = (y * 9 + i).to_i

        if grid[index_row] == "0"
          related[index_row] = 1
        else
          numbers &= REMOVE[grid[index_row].to_i]
        end

        index_col = (i * 9 + x).to_i

        if grid[index_col] == "0"
          related[index_col] = 1
        else
          numbers &= REMOVE[grid[index_col].to_i]
        end
      end

      # Check the square
      (0..2).each do |y2|
        (0..2).each do |x2|
          index_square = ((y / 3).floor * 3 + y2) * 9 + ((x / 3).floor * 3 + x2)

          if grid[index_square] == "0"
            related[index_square] = 1
          else
            numbers &= REMOVE[grid[index_square].to_i]
          end
        end
      end

      related.delete(index)

      possible_numbers[index] = numbers # We save the possibilities
      relations[index] = related # The positions we need to update when setting this position
      position_to_find[index] = 1 # This position needs to be found
    end
  end
end

def set_numbers(grid, possible_numbers, relations, position_to_find)
  # Setting number might leave only 1 possibility for other positions
  loop do
    number_found = false

    position_to_find.each do |index, _|
      case possible_numbers[index]
      when 1 then value = 1
      when 2 then value = 2
      when 4 then value = 3
      when 8 then value = 4
      when 16 then value = 5
      when 32 then value = 6
      when 64 then value = 7
      when 128 then value = 8
      when 256 then value = 9
      else next
      end

      number_found = true

      # Update the grid
      grid[index] = value.to_s

      # We can only use this number once in the row/col & square
      relations[index].each do |index_to_check, _|
        if (possible_numbers[index_to_check] &= REMOVE[value]) == 0
          return -1
        end
      end

      position_to_find.delete(index)
    end

    break unless number_found
  end

  return position_to_find.empty? ? 1 : 0
end

# Guess a number for the sudoku
def get_guess(index, possible_numbers, forbidden)
  numbers = possible_numbers[index]

  VALUES.each do |value, mask|
    # We already tried, we got an invalid grid
    next if forbidden[index] && forbidden[index][value]

    # This is a possible number for the position
    if numbers & mask != 0
      forbidden[index] ||= {}
      forbidden[index][value] = 1
      possible_numbers[index] = mask

      return true
    end
  end

  # All the possibilities for this position are forbidden, invalid grid
  false
end

backups = []
forbidden = []

# Solve the sudoku
loop do
  # We start by setting all the positions with only one possibility
  result = set_numbers(grid, possible_numbers, relations, position_to_find)

  break if result == 1 # Solution has been found

  # Until we find a guess to test
  loop do
    to_check = []

    # Invalid grid, reload last backup
    if result == -1
      grid, possible_numbers, forbidden, position_to_find = backups.pop
    end

    temp = possible_numbers.dup

    # No possible guess, invalid grid
    if !get_guess(position_to_find.keys.first, possible_numbers, forbidden)
      result = -1
    else
      # We have a guess, backup info
      backups << [grid.dup, temp, forbidden.dup, position_to_find.dup]
      break
    end
  end
end

puts grid.chars.each_slice(9).map(&:join).join("\n")

# Log the time taken
error_logger = File.open('error_log.txt', 'a')
error_logger.puts(Time.now - start_time)
error_logger.close
