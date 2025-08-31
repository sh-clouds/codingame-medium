N = gets.to_i
map = Array.new(N) { gets.strip.split }

direction = case map[0][0]
            when '|' then 'R'
            when '-' then 'D'
            when '/' then 'DR'
            end

to_check = [[0, 0, direction]]

while !to_check.empty?
  x, y, d = to_check.pop

  next if x >= N || x < 0 || y >= N || y < 0

  domino = map[y][x]

  next if domino == '.'
  next if (domino == '|' && (d == 'D' || d == 'U'))
  next if (domino == '-' && (d == 'L' || d == 'R'))
  next if (domino == '/' && (d.include?('UR') || d.include?('DL')))
  next if (domino == '\\' && (d.include?('DR') || d.include?('UL')))

  map[y][x] = '.'

  case domino
  when '|'
    to_check << [x + 1, y, 'R'] if d.include?('R')
    to_check << [x - 1, y, 'L'] if d.include?('L')
  when '-'
    to_check << [x, y + 1, 'D'] if d.include?('D')
    to_check << [x, y - 1, 'U'] if d.include?('U')
  when '/'
    if d.include?('R') || d.include?('D')
      to_check << [x + 1, y, 'R']
      to_check << [x + 1, y + 1, 'DR']
      to_check << [x, y + 1, 'D']
    end
    if d.include?('L') || d.include?('U')
      to_check << [x - 1, y, 'L']
      to_check << [x - 1, y - 1, 'UL']
      to_check << [x, y - 1, 'U']
    end
  when '\\'
    if d.include?('R') || d.include?('U')
      to_check << [x + 1, y, 'R']
      to_check << [x + 1, y - 1, 'UR']
      to_check << [x, y - 1, 'U']
    end
    if d.include?('L') || d.include?('D')
      to_check << [x - 1, y, 'L']
      to_check << [x - 1, y + 1, 'DL']
      to_check << [x, y + 1, 'D']
    end
  end
end

count = 0

map.each do |line|
  line.each do |c|
    count += 1 if c != '.'
  end
end

puts count
