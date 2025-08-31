keys = Array.new(5) { gets.chomp.split }
dictionary = Hash.new { |hash, key| hash[key] = nil }
(0...5).each do |y|
  (0...5).each do |x|
    dictionary[keys[y][x]] = [x, y]
  end
end
dm = gets.chomp == 'ENCRYPT' ? 1 : -1

(0...gets.to_i).each do
  msg = gets.chomp.upcase.chars.select { |a| dictionary.key?(a) }
  if msg.length.odd?
    puts 'DUD'
  else
    (0...(msg.length / 2)).each do |i|
      x1, y1 = dictionary[msg[2 * i]]
      x2, y2 = dictionary[msg[2 * i + 1]]
      if y1 == y2
        x1, x2 = (x1 + dm) % 5, (x2 + dm) % 5
      elsif x1 == x2
        y1, y2 = (y1 + dm) % 5, (y2 + dm) % 5
      else
        x1, x2 = x2, x1
      end
      print keys[y1][x1], keys[y2][x2]
    end
    puts
  end
end