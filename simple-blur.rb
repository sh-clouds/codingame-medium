# Read the number of rows and columns from standard input
rows, cols = gets.chomp.split.map(&:to_i)
image = Array.new(rows) { Array.new(cols) }

# Read the image data from standard input
(0...rows).each do |y|
  (0...cols).each do |x|
    image[y][x] = gets.chomp.split.map(&:to_i)
  end
end

# Process each pixel in the image
(0...rows).each do |y|
  (0...cols).each do |x|
    values = [image[y][x]]
    values << image[y][x - 1] if x > 0
    values << image[y][x + 1] if x < cols - 1
    values << image[y - 1][x] if y > 0
    values << image[y + 1][x] if y < rows - 1

    count = values.size

    # Output the averaged color values
    puts "#{(values.sum { |v| v[0] } / count.to_f).floor} " \
         "#{(values.sum { |v| v[1] } / count.to_f).floor} " \
         "#{(values.sum { |v| v[2] } / count.to_f).floor}"
  end
end