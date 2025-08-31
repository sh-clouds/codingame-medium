# Include necessary libraries
require 'json'

# Define color constants
class Colour
  NO_COL = 0
  BLACK_R = 1
  WHITE_R = 2
  BOTH_R = 3
  HAS_ST = 4
  BLACK = 5
  WHITE = 6
end

grid = Array.new(400, 0)
l = 0

def char_to_col(character)
  if character == '.'
    return Colour::NO_COL
  elsif character == 'B'
    return Colour::BLACK
  elsif character == 'W'
    return Colour::WHITE
  end
end

def fill_grid(grid, l)
  change_occurred = true

  while change_occurred
    change_occurred = false
    (0...L).each do |i|
      (0...L).each do |j|
        next if grid[i * l + j] >= Colour::BOTH_R

        top = (i == 0) ? Colour::NO_COL : grid[(i - 1) * L + j]
        left = (j == 0) ? Colour::NO_COL : grid[i * L + j - 1]
        bottom = (i == L - 1) ? Colour::NO_COL : grid[(i + 1) * L + j]
        right = (j == L - 1) ? Colour::NO_COL : grid[i * L + j + 1]
        accumulated = grid[i * L + j] | top | bottom | left | right
        accumulated &= ~Colour::HAS_ST
        change_occurred ||= grid[i * L + j] != accumulated

        grid[i * L + j] = accumulated
      end
    end
  end
end

def compute_score(grid, l)
  white_score = 6
  black_score = 0

  (0...(L * L)).each do |i|
    if (grid[i] & ~Colour::HAS_ST) == Colour::WHITE_R
      white_score += 1
    elsif (grid[i] & ~Colour::HAS_ST) == Colour::BLACK_R
      black_score += 1
    end
  end

  puts "BLACK : #{black_score}"
  puts "WHITE : #{white_score}.5"
  puts black_score > white_score ? 'BLACK WINS' : 'WHITE WINS'
end

if __FILE__ == $0
  ROW = Array.new(1025, '')
  L = gets.to_i
  
  (0...L).each do |i|
    ROW[i] = gets.strip
    (0...L).each do |j|
      grid[i * L + j] = char_to_col(ROW[i][j])
    end
  end
  
  fill_grid(grid, L)
  compute_score(grid, L)
end