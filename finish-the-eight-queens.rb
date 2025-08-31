class NQueens
  # Generate all valid solutions for the n queens puzzle
  def initialize(size)
    # Store the puzzle (problem) size and the number of valid solutions
    @size = size
    @solutions = 0
    @a = []
    solve
  end

  def solve
    # Solve the n queens puzzle and print the number of solutions
    positions = Array.new(@size, -1)
    put_queen(positions, 0)
    # puts "Found #{@solutions} solutions."
  end

  def put_queen(positions, target_row)
    # Try to place a queen on target_row by checking all N possible cases.
    # If a valid place is found the function calls itself trying to place a queen
    # on the next row until all N queens are placed on the NxN board.

    # Base (stop) case - all N rows are occupied
    if target_row == @size
      show_full_board(positions)
      # show_short_board(positions)
      @solutions += 1
    else
      # For all N columns positions try to place a queen
      (0...@size).each do |column|
        # Reject all invalid positions
        if check_place(positions, target_row, column)
          positions[target_row] = column
          put_queen(positions, target_row + 1)
        end
      end
    end
  end

  def check_place(positions, occupied_rows, column)
    # Check if a given position is under attack from any of
    # the previously placed queens (check column and diagonal positions)
    (0...occupied_rows).each do |i|
      return false if positions[i] == column ||
                      positions[i] - i == column - occupied_rows ||
                      positions[i] + i == column + occupied_rows
    end
    true
  end

  def show_full_board(positions)
    # Show the full NxN board
    (0...@size).each do |row|
      line = ""
      (0...@size).each do |column|
        line += positions[row] == column ? "Q" : "."
      end
      @a << line
    end
  end

  def show_short_board(positions)
    # Show the queens positions on the board in compressed form,
    # each number represents the occupied column position in the corresponding row.
    line = ""
    (0...@size).each do |i|
      line += "#{positions[i]} "
    end
    puts line
  end

  def get_scope()
    return @a
  end
end

# Initialize and solve the n queens puzzle
def is_sub_array(array_a, array_b)
  array_a.all? { |i| array_b.include?(i) }
end

n_queens = NQueens.new(8)

queens_input = []
(0...8).each do |i|
  row = gets.chomp
  (0...8).each do |j|
    queens_input << [i, j] if row[j] == 'Q'
  end
end

queens = []
boards = []
i = 0
a = n_queens.get_scope()

a.each do |row|
  row.each_char.with_index do |char, j|
    if char == 'Q'
      queens << [i, j]
      i += 1
      if i == 8
        boards << queens
        i = 0
        queens = []
      end
    end
  end
end

boards.each do |queens|
  if is_sub_array(queens_input, queens)
    queens.each do |queen|
      line = ""
      (0...8).each do |column|
        line += queen[1] == column ? "Q" : "."
      end
      puts line
    end
  end
end




