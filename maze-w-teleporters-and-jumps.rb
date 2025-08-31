MOVES = [[0, -1], [-1, 0], [0, 1], [1, 0]]

width = gets.to_i
height = gets.to_i
x_start = nil
y_start = nil
jumps = {}
map = Array.new(height) { Array.new(width) }

(0...height).each do |y|
    gets.chomp.chars.each_with_index do |c, x|
        #Starting position
        if c == "S"
            x_start = x
            y_start = y
            c = "_"
        #Exit of a teleporter
        elsif c =~ /[A-Z]/ && c != "E"
            jumps[c.downcase] = [x, y]
            c = "_"
        end

        map[y][x] = c
    end
end

step = 0
visited = {}
to_check = [[x_start, y_start]]

until to_check.empty?
    new_check = []
    
    to_check.each do |x, y|
        #Reached the target point
        if map[y][x] == "E"
            puts step
            exit
        end

        #Outside or in wall
        next if x < 0 || x >= width || y < 0 || y >= height || map[y][x] == "#"

        #Already visited
        next if visited[[y, x]]
        visited[[y, x]] = true

        #It's jumping time until we land on an empty cell or the target point
        while map[y][x] != "_"
            case map[y][x]
            when "E"
                puts step
                exit
            when "<"
                x -= 2
            when ">"
                x += 2
            when "^"
                y -= 2
            when "v"
                y += 2
            else
                x, y = jumps[map[y][x]]
            end
        end
        
        MOVES.each do |xm, ym|
            new_check << [x + xm, y + ym]
        end
    end

    to_check = new_check
    step += 1
end

puts "-1" #Impossible to reach the end