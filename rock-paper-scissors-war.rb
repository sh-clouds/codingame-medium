BATTLE_RESULTS = {
  "R" => { "R" => 1, "P" => 0, "C" => 1, "L" => 1, "S" => 0 },
  "P" => { "R" => 1, "P" => 1, "C" => 0, "L" => 0, "S" => 1 },
  "C" => { "R" => 0, "P" => 1, "C" => 1, "L" => 1, "S" => 0 },
  "L" => { "R" => 0, "P" => 1, "C" => 0, "L" => 1, "S" => 1 },
  "S" => { "R" => 1, "P" => 0, "C" => 1, "L" => 0, "S" => 1 },
}

# Returns the winner of a duel
def battle(player1, player2)
  return player1 if BATTLE_RESULTS[player1][player2] != 0
  player2
end

width, height, num_fights = gets.chomp.split.map(&:to_i)
grid = Array.new(height) { gets.chomp.strip }

num_fights.times do
  fight_grid = Array.new(height) { Array.new(width, '0') }

  height.times do |y|
    width.times do |x|
      winners = []

      # Get the winners of the 4 duels
      winners << battle(grid[y][x], grid[y][x - 1]) if x > 0
      winners << battle(grid[y][x], grid[y][x + 1]) if x < width - 1
      winners << battle(grid[y][x], grid[y - 1][x]) if y > 0
      winners << battle(grid[y][x], grid[y + 1][x]) if y < height - 1

      # Same can win several, remove duplicates
      winners.uniq!

      # We have more than one winner, make them duel each other
      while winners.size > 1
        winners << battle(winners.pop, winners.pop)
      end
      
      fight_grid[y][x] = winners.pop
    end
  end

  grid = fight_grid
end

puts grid.map(&:join).join("\n")