# We add a layer around the board:
# - Takes care of move position starting at index 1
# - Takes care of extra checks that would be needed to see if we are out of the board when moving in each directions
grid = Array.new(10) { "-" * 10 }
counts = { 'B' => 0, 'W' => 0, '-' => 0 }

(1..8).each do |y|
  line = gets.chomp
  line.chars.each_with_index do |c, x|
    counts[c] += 1
    grid[y][x + 1] = c
  end
end

colour, move = gets.chomp.split

flipped = 0
opposite = (colour == "W") ? "B" : "W"
x = move[0].ord - 96
y = move[1].to_i

if grid[y][x] != "-" 
  print("NOPE") # Cell is already filled not allowed
  exit
end

# We check the 8 directions
[[0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1]].each do |move|
  xm = x
  ym = y
  count = 0

  # Until we reach a cell that's not the other player color
  loop do
    xm += move[0]
    ym += move[1]

    if grid[ym][xm] != opposite
      flipped += count if grid[ym][xm] == colour # Sandwich 
      break
    end

    count += 1
  end 
end

# Nothing was flipped
if flipped.zero?
  puts "NULL"
# Update the counts and show them
else
  counts[colour] += flipped + 1 # Don't forget the one we place
  counts[opposite] -= flipped
  
  puts "#{counts['W']} #{counts['B']}"
end