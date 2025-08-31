n = gets.to_i

output = Array.new(n) { "." * n }

info = []

n.times do |y|
  gets.chomp.chars.each_with_index do |c, x|
    #It's a digit, need to get the info
    if c.match?(/\d/)
      neighbors = []

      #Get all the neighbors of this position
      ([(y - 1), 0].max..[(y + 1), (n - 1)].min).each do |y2|
        ([(x - 1), 0].max..[(x + 1), (n - 1)].min).each do |x2|
          neighbors << [x2, y2]
        end
      end

      info << [c.to_i, neighbors]
    end
  end
end

until info.empty?
  info.each_with_index do |(count, neighbors), i|
    possibilities = []
    occupied = []

    #Check all the neighbors to see how many are occupied and how many could be occupied
    neighbors.each do |x, y|
      if output[y][x] == '.'
        possibilities << [x, y]
      elsif output[y][x] == '#'
        occupied << [x, y]
      end
    end

    count_possibility = possibilities.size
    count_occupied = occupied.size

    #This digit is already satisfied
    if count_occupied == count
      info.delete_at(i)

      #We know all these have to be empty
      possibilities.each { |x, y| output[y][x] = '@' } if count_possibility > 0

    elsif count_possibility + count_occupied == count
      #Mark them all as occupied
      possibilities.each { |x, y| output[y][x] = '#' }

      info.delete_at(i)
    end
  end
end

puts output.map { |line| line.tr('@', '.') }.join("\n")