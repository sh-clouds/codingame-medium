STDOUT.sync = true # DO NOT REMOVE

nb_floors, width, nb_rounds, exit_floor, exit_position, nb_total_clones, nb_additional_elevators, nb_elevators = gets.chomp.split.map(&:to_i)
elevators = {}
nb_elevators.times do
  floor, position = gets.chomp.split.map(&:to_i)
  elevators[floor] = position
end

loop do
  current_floor, current_position, direction = gets.chomp.split
  current_floor = current_floor.to_i
  current_position = current_position.to_i
  target_position = elevators.fetch(current_floor, exit_position)

  if (direction == "RIGHT" && target_position < current_position) || (direction == "LEFT" && target_position > current_position)
    puts "BLOCK"
  else
    puts "WAIT"
  end
end