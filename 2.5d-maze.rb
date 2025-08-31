start_y, start_x = gets.strip.split.map(&:to_i)
end_y, end_x = gets.strip.split.map(&:to_i)
height, width = gets.strip.split.map(&:to_i)

map_data = [nil, nil]
height.times do
  line = gets.strip
  map_data[0] ||= []
  map_data[1] ||= []
  map_data[0] << line.gsub('+', '#')
  map_data[1] << line.gsub('.', '#')
end

links = [{ x: start_x, y: start_y, level: 0, dir: ' ' }]
distance = 0

while !links.empty?
  new_links = []
  links.each do |link|
    level = link[:level]
    x = link[:x]
    y = link[:y]
    direction = link[:dir]
    character = map_data[level][y][x]
    
    if character == '#' || (character == '|' && direction == 'h') || (character == '-' && direction == 'v')
      next
    end
    level = (character == '-' || character == '|') ? 1 - level : level
    if x == end_x && y == end_y
      puts distance
      exit
    end
    
    map_data[level][y][x] = '#'
    
    unless character == '|'
      new_links << { x: x + 1, y: y, level: level, dir: 'h' }
      new_links << { x: x - 1, y: y, level: level, dir: 'h' }
    end
    
    unless character == '-'
      new_links << { x: x, y: y + 1, level: level, dir: 'v' }
      new_links << { x: x, y: y - 1, level: level, dir: 'v' }
    end
  end

  distance += 1
  links = new_links
end