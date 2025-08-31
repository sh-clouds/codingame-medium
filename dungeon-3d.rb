# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

L, R, C = gets.split.map(&:to_i)
ln = gets.to_i

floor = 0
paths = nil
map = []

ln.times do |i|
  line = gets.chomp

  unless line.empty?
    map[floor] ||= []
    map[floor] << line
  else
    floor += 1
  end

  # We save the initial position
  if paths.nil? && (position = line.index('A'))
    paths ||= []
    paths[0] = ["#{floor},#{i - (R + 1) * (floor - 1) - 1},#{position}"]
  end
end

already_explored = []
index = 0

begin
  # Check all the positions we can reach in index move
  paths[index].each do |position|
    floor, row, column = position.split(',').map(&:to_i)

    directions = [
      "#{floor},#{row - 1},#{column}", # up
      "#{floor},#{row + 1},#{column}", # down
      "#{floor},#{row},#{column - 1}", # left
      "#{floor},#{row},#{column + 1}", # right
      "#{floor + 1},#{row},#{column}", # top
      "#{floor - 1},#{row},#{column}"  # down
    ]

    # Check all the possible directions from the current position
    directions.each do |position_to_check|
      floor, row, column = position_to_check.split(',').map(&:to_i)

      # We are out of the map, we skip
      next if floor < 1 || floor > L || row < 0 || row >= R || column < 0 || column >= C

      # Skip if we have already explored this position
      unless already_explored.include?(position_to_check)
        character = map[floor][row][column]

        # We reached the source
        if character == 'S'
          puts index + 1
          exit
        # We can move to this position
        elsif character == '.'
          paths[index + 1] ||= []
          paths[index + 1] << position_to_check
        end

        # Don't test this position again
        already_explored << position_to_check
      end
    end
  end
  index += 1
end while paths[index]

puts "NO PATH"