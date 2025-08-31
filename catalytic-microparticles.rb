length, width, height = gets.strip.split.map(&:to_i)

shape = Array.new(width) { Array.new(length) { Array.new(height) { nil } } }

(0...length).each do |y|
  gets.strip.split.each_with_index do |line, z|
    line.chars.each_with_index do |character, x|
      shape[x][y][z] = character
    end
  end
end

# We need to mark all the "holes" that are part of the 'exterior'
(0...width).each do |x|
  (0...length).each do |y|
    (0...height).each do |z|
      # Any holes starting at the exterior of the cube
      if (x == 0 || x == width - 1 || y == 0 || y == length - 1 || z == 0 || z == height - 1) && shape[x][y][z] == 'o'
        to_check = [[x, y, z]]

        until to_check.empty?
          x2, y2, z2 = to_check.pop

          next if shape[x2][y2][z2] != 'o'
          shape[x2][y2][z2] = 'E'

          # We can move in the 3 directions
          [[1, 0, 0], [-1, 0, 0], [0, 1, 0], [0, -1, 0], [0, 0, 1], [0, 0, -1]].each do |xm, ym, zm|
            xu = xm + x2
            yu = ym + y2
            zu = zm + z2

            if (0 <= xu && xu < width && 0 <= yu && yu < length && 0 <= zu && zu < height && shape[xu][yu][zu] == 'o')
              to_check << [xu, yu, zu]
            end
          end
        end
      end
    end
  end
end

surface_area = 0
material_count = 0
holes_count = 0

(0...width).each do |x|
  (0...length).each do |y|
    (0...height).each do |z|
      if shape[x][y][z] == '#'
        material_count += 1

        # For each position we check the 6 faces (left, right, up, down, front, back), if we have an exterior piece or if we are outside this face is part of the surface area
        surface_area += 1 if (x > 0 ? shape[x - 1][y][z] : 'E') == 'E'  # Left
        surface_area += 1 if (x < width - 1 ? shape[x + 1][y][z] : 'E') == 'E'  # Right
        surface_area += 1 if (y > 0 ? shape[x][y - 1][z] : 'E') == 'E'  # Up
        surface_area += 1 if (y < length - 1 ? shape[x][y + 1][z] : 'E') == 'E'  # Down
        surface_area += 1 if (z < height - 1 ? shape[x][y][z + 1] : 'E') == 'E'  # Front
        surface_area += 1 if (z > 0 ? shape[x][y][z - 1] : 'E') == 'E'  # Back
      end
      holes_count += 1 if shape[x][y][z] == 'o'
    end
  end
end

puts format('%.4f %.4f', surface_area.to_f / material_count, material_count.to_f / (material_count + holes_count))
