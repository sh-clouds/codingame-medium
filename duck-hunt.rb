# Read width and height from standard input
width = gets.to_i
height = gets.to_i

positions = {}
birds = {}

(0...height).each do |y|
  gets.chomp.chars.each_with_index do |character, x|
    if character.match?(/\d/)
      positions[character] = [x, y]
    end
  end
end

(0...height).each do |y|
  gets.chomp.chars.each_with_index do |character, x|
    if character.match?(/\d/)
      # Get movement of the bird
      velocity_x = x - positions[character][0]
      velocity_y = y - positions[character][1]
      
      # How many turns do we have before we can't shoot that bird anymore
      turns = Float::INFINITY
      
      if velocity_x < 0
        turns = [turns, x.abs / velocity_x.abs].min
      elsif velocity_x > 0
        turns = [turns, (width - x - 1) / velocity_x].min
      end
      
      if velocity_y < 0
        turns = [turns, y.abs / velocity_y.abs].min
      elsif velocity_y > 0
        turns = [turns, (height - y - 1) / velocity_y].min
      end
      
      birds[character] = [turns, velocity_x, velocity_y, x, y]
    end
  end
end

# Sort by the number of turns we have to shoot it
birds = birds.sort_by { |_, values| values[0] }.to_h

current_turn = 1

birds.each do |id, (turn, velocity_x, velocity_y, x, y)|
  next if turn < current_turn # It's too late to shoot that bird
  
  puts "#{id} #{x + (current_turn * velocity_x)} #{y + (current_turn * velocity_y)}"
  
  current_turn += 1
end