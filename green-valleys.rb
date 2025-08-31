height_limit = gets.to_i
number_of_rows = gets.to_i
map_data = Array.new(number_of_rows) { gets.strip.split.map(&:to_i) }

answer = [0, 0]
visited = Array.new(number_of_rows) { Array.new(number_of_rows, 0) }

(0...number_of_rows).each do |y|
  (0...number_of_rows).each do |x|
    if map_data[y][x] > height_limit || visited[y][x] != 0
      next
    end

    # Simple floodfill
    to_explore = [[x, y]]
    size = 0
    deepest = Float::INFINITY

    until to_explore.empty?
      xv, yv = to_explore.pop

      if visited[yv][xv] != 0
        next
      else
        visited[yv][xv] = 1
      end

      size += 1
      deepest = [deepest, map_data[yv][xv]].min

      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |xm, ym|
        xu = xv + xm
        yu = yv + ym

        if (0 <= xu && xu < number_of_rows) && (0 <= yu && yu < number_of_rows) && (map_data[yu][xu] <= height_limit)
          to_explore.push([xu, yu])
        end
      end
    end

    # The valley is bigger or has the same size with a deepest part
    if size > answer[0] || (size == answer[0] && deepest < answer[1])
      answer = [size, deepest]
    end
  end
end

puts answer[1]