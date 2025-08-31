require 'set'

def search_opposite(galaxy, w, h, pos)
  step = 0
  visited = Set.new
  positions = [[pos, '', 0]] # (coordinates, previous direction axis, number of axis changes along the path)
  
  while !positions.empty?
    step += 1
    visited.merge(positions.map { |p| p[0] }) # update visited positions
    next_step = []
    
    positions.each do |xy, axis, dir_chg| # iterate through current step positions
      [[-1, 0], [0, -1], [1, 0], [0, 1]].each do |dx, dy|
        x, y = xy[0] + dx, xy[1] + dy
        move_axis = 'xy'[dy != 0 ? 1 : 0] # current move axis x or y
        
        if y >= 0 && y < h && x >= 0 && x < w && galaxy[y][x] != '.' && !visited.include?([x, y]) # collect all yet unvisited cube edges from pos
          updated_dir_chg = dir_chg + (axis != '' && axis != move_axis ? 1 : 0)
          if step >= 2 && updated_dir_chg % 2 == 0 # our opposite edge is at least two steps away with 0 or 2 direction changes (for any of 11 planar cube layouts)
            return [x, y]
          end
          next_step << [[x, y], move_axis, updated_dir_chg]
        end
      end
    end
    positions = next_step
  end
  raise 'Opposite not found'
end

w, h = gets.to_i, gets.to_i
galaxy = Array.new(h) { gets.chomp.tr('6', '#').chars } # read galaxy map, remove possible incorrect placed sixes

(0...h).each do |y|
  (0...w).each do |x|
    if galaxy[y][x] == '1'
      ox, oy = search_opposite(galaxy, w, h, [x, y])
      galaxy[oy][ox] = '6'
    end
  end
end

galaxy.each { |line| puts line.join }