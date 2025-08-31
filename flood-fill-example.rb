class TowerNode
    attr_accessor :id

    def initialize(id)
        @id = id
    end
end

w = gets.to_i
h = gets.to_i
map = []
h.times do
  map << gets.chomp.split('')
end
master_queue = []
queue = []
h.times do |y|
    w.times do |x|
        map_point = map[y][x]
        if map_point != '.' && map_point != '#'
            tower_node = TowerNode.new(map_point)
            map[y][x] = tower_node.id
            master_queue << [[x, y], tower_node]
        end
    end
end

offsets = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0],
]

until master_queue.empty?
    queue = master_queue
    master_queue = []
    current_turn_positions = []
    until queue.empty?
        location, node = queue.shift
        x, y = location
        offsets.each do |offset_x, offset_y|
            next_x = offset_x + x
            next_y = offset_y + y
            next_location = [next_x, next_y]
            next unless next_x >= 0 && next_x < w && next_y >= 0 && next_y < h

            if map[next_y][next_x] != '#' && current_turn_positions.any? do |location, previous_node|
                location == next_location && previous_node != node
            end
                current_turn_positions << [next_location, node]
                map[next_y][next_x] = '+'
                master_queue << [next_location, node]
            elsif map[next_y][next_x] == '.'
                current_turn_positions << [next_location, node]
                map[next_y][next_x] = node.id
                master_queue << [next_location, node]
            end
        end
    end
end

map.each do |row|
    puts row.join('')
end
