def dist(point_a, point_b)
  (point_b[0] - point_a[0])**2 + (point_b[1] - point_a[1])**2
end

def centre(points)
  index_sum_i = 0
  index_sum_j = 0
  points.each do |point|
    index_sum_j += point[0]
    index_sum_i += point[1]
  end
  index_sum_i /= points.length
  index_sum_j /= points.length
  if $grille[index_sum_i][index_sum_j] == "#"
    return "FILLED"
  else
    return "EMPTY"
  end
end

top = []
left = []
right = []
bottom = []
$grille = []
20.times do |i|
  line = gets.chomp.split
  $grille << line
  if line.include?("#")
    index_first_hash = line.index("#")
    index_last_hash = 19 - line.reverse.index("#")
    if top.empty?
      top << [index_first_hash, i]
      if index_last_hash != index_first_hash
        top << [index_last_hash, i]
      end
    else
      if index_first_hash < top[0][0]
        if left.empty? || index_first_hash < left[0][0]
          left = [[index_first_hash, i]]
        end
      end
      bottom = [[index_first_hash, i]]
      if index_last_hash != index_first_hash
        if index_last_hash > top[-1][0]
          if right.empty? || index_last_hash > right[0][0]
            right = [[index_last_hash, i]]
          end
        end
        bottom << [index_last_hash, i]
      end
    end
  end
end

points = (top + right + bottom + left).uniq.sort

number_of_points = points.length
if number_of_points == 1
  name = "POINT"
elsif number_of_points == 2
  name = "LINE"
elsif number_of_points == 3
  name = centre(points)
  name += " TRIANGLE"
else
  name = centre(points)
  if dist(points[0], points[1]) == dist(points[0], points[2])
    name += " SQUARE"
  else
    name += " RECTANGLE"
  end
end
puts "#{name} #{points.map { |point| "(#{point[0]},#{point[1]})" }.join(' ')}"