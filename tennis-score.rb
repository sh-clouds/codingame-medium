names = gets.strip.split(" ")
n = gets.to_i
points = gets.strip.split(" ")

finished = false
set = 1
games = [[0, {1 => 0}], [0, {1 => 0}]]
scores = [0, 0]
tie_break = false

points.each do |point|
  binary = point.to_i(16).to_s(2).rjust(8, '0')

  binary.each_char do |byte|
    scores[byte.to_i] += 1

    # Has a player won a game?
    if scores[byte.to_i] >= (tie_break ? (n == set ? 10 : 7) : 4) && (scores[byte.to_i] - scores[(byte.to_i + 1) % 2] >= 2)
      games[byte.to_i][1][set] += 1

      # Has a player won a set?
      if games[byte.to_i][1][set] >= 6 && (games[byte.to_i][1][set] - games[(byte.to_i + 1) % 2][1][set] >= (tie_break ? 1 : 2))
        # We were in a tie-break, reset it
        tie_break = false if tie_break

        games[byte.to_i][0] += 1

        # Game is over one of the player won enough sets
        if games[byte.to_i][0] > (n >> 1)
          finished = true
          break 2
        end

        set += 1
        games[0][1][set] = 0
        games[1][1][set] = 0
      # We reached 6 - 6 => entering tie-break
      elsif games[byte.to_i][1][set] == 6 && games[(byte.to_i + 1) % 2][1][set] == 6
        tie_break = true
      end

      scores = [0, 0]
    end
  end
end

score_mapping = {0 => 0, 1 => 15, 2 => 30, 3 => 40}

if tie_break || finished
  output_scores = scores
# We need to change the scores of the current game
elsif scores[0] >= 4 || scores[1] >= 4
  # Equality
  if scores[0] == scores[1]
    output_scores = [40, 40]
  # Avantage player 1 
  elsif scores[0] > scores[1]
    output_scores = ["AV", "-"]
  # Avantage player 2 
  else
    output_scores = ["-", "AV"]
  end
else
  output_scores = [score_mapping[scores[0]], score_mapping[scores[1]]]
end

# Game is over
if finished
  puts "#{names[0].ljust(15, '.')} #{games[0][1].values.join(' ')}"
  puts "#{names[1].ljust(15, '.')} #{games[1][1].values.join(' ')}"
  puts "#{games[0][0] > games[1][0] ? names[0] : names[1]} wins"
# Game is ongoing
else
  puts "#{names[0].ljust(15, '.')} #{games[0][1].values.join(' ')} | #{output_scores[0]}"
  puts "#{names[1].ljust(15, '.')} #{games[1][1].values.join(' ')} | #{output_scores[1]}"
  puts "Game in progress"
end