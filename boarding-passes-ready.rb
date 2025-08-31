LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

height = gets.to_i
width = gets.to_i
number_of_passengers = gets.to_i
passengers = {}

number_of_passengers.times do
  info = gets.chomp.split(",").map(&:strip)
  passengers[info[1]] = info[0]
end

while passengers.any? do
  calling = { 'L' => [], 'R' => [] }

  # We call passengers from back to front 
  (height).downto(1) do |y|
    # Boarding group 1, pick the first passenger still waiting from the left
    (0...(width / 2)).each do |x|
      seat_left = "#{y}#{LETTERS[x]}"

      if passengers.key?(seat_left)
        calling['L'] << passengers[seat_left]
        passengers.delete(seat_left)
        break
      end
    end

    # Boarding group 2, pick the first passenger still waiting from the right
    ((width - 1).downto(width / 2)).each do |x|
      seat_right = "#{y}#{LETTERS[x]}"

      if passengers.key?(seat_right)
        calling['R'] << passengers[seat_right]
        passengers.delete(seat_right)
        break
      end
    end
  end

  puts "Now boarding: #{calling['L'].join(',')}" if calling['L'].any?
  puts "Now boarding: #{calling['R'].join(',')}" if calling['R'].any?
end