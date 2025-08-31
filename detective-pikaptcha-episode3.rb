STDOUT.sync = true # DO NOT REMOVE
$width, $height = gets.split.map(&:to_i)
x = y = nil
direction = nil
grid = []
$height.times do |j|
    grid << gets.chomp.chars.map { |c| c =~ /\d/ ? c.to_i : c }
    if x
        next
    end
    "^>v<".chars.each_with_index do |d, k|
        if grid[-1].include?(d)
            x, y = grid[-1].index(d), j
            direction = k
            grid[-1][x] = 0
            break
        end
    end
end
side = gets.chomp
start_position = [x, y]

def forward(x, y, direction)
    new_position = [[x, y - 1], [x + 1, y], [x, y + 1], [x - 1, y]][direction]
    new_x, new_y = new_position
    if new_y < 0 || new_y >= $height
        return [(new_x + $width / 2) % $width, new_y % $height, false]
    end
    return [new_x % $width, new_y, false]
end

def can_move_to(x, y, grid)
    grid[y][x] != "#"
end

def left(direction)
    (direction - 1) % 4
end

def right(direction)
    (direction + 1) % 4
end

def wall(direction, side)
    [method(:left), method(:right)][side == "R" ? 1 : 0].call(direction)
end

def not_wall(direction, side)
    [method(:right), method(:left)][side == "R" ? 1 : 0].call(direction)
end

count = 0
loop do
    # puts "#{x} #{y} #{'^>v<'[direction]}"

    # check wall
    new_x, new_y, status = forward(x, y, wall(direction, side))
    if can_move_to(new_x, new_y, grid)
        direction = wall(direction, side)
    end

    # still next to the wall
    new_x, new_y, status = forward(x, y, direction)
    if can_move_to(new_x, new_y, grid)
        x, y = new_x, new_y
        grid[y][x] += 1
        count = 0
        if status
            side = side == "R" ? "L" : "R"
        end
    else
        direction = not_wall(direction, side)
        count += 1
        break if count >= 4
        next
    end

    break if start_position == [x, y]
end

grid.each do |line|
    puts line.join
end