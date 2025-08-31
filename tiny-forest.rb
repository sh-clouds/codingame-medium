def plant(coordinate, width, height, grid, seeds)
  i, j = coordinate
  neighbors = [[i-1, j], [i+1, j], [i, j-1], [i, j+1]]
  neighbors.select! { |a, b| a >= 0 && b >= 0 && a < width && b < height && grid[b][a] == "." }
  return grid, seeds if neighbors.empty?

  neighbors.each do |a, b|
    grid[b][a] = "X"
    seeds[[a, b]] = 0
  end
  return grid, seeds
end

grid = []
width = gets.to_i
height = gets.to_i
trees = []

height.times do |j|
  row = gets.chomp.chars
  row.each_with_index do |letter, i|
    trees << [i, j] if letter == "Y"
  end
  grid << row
end

max_counts = []

height.times do |j|
  width.times do |i|
    if grid[j][i] == "."
      seeds = { [i, j] => 0 }
      grid_copy = Marshal.load(Marshal.dump(grid))
      trees_copy = trees.dup
      grid_copy[j][i] = "X"
      count = 0

      (1..33).each do |age|
        trees_copy.each do |coordinate|
          grid_copy, seeds = plant(coordinate, width, height, grid_copy, seeds)
        end

        new_trees = []
        to_delete = []
        seeds.each do |coordinate, age|
          seeds[coordinate] += 1
          if seeds[coordinate] == 10
            to_delete << coordinate
            grid_copy[coordinate[1]][coordinate[0]] = "Y"
            new_trees << coordinate
          end
        end

        to_delete.each { |coordinate| seeds.delete(coordinate) }
        trees_copy = new_trees
      end

      grid_copy.each { |line| count += line.count("Y") }
      max_counts << count
    end
  end
end

puts max_counts.max