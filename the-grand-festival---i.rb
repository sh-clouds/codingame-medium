number_of_prizes = gets.to_i
number_of_rest_days = gets.to_i
prizes = []

number_of_prizes.times do
  prizes << gets.to_i
end

days = Array.new(number_of_rest_days + 1, 0)

# Check all the prizes starting from the end
(number_of_prizes - 1).downto(0) do |i|
  new_days = []

  # Check the best prizes if we reach this day with j days since we rested
  (1..number_of_rest_days).each do |j|
    new_days[j - 1] = [days[0], prizes[i] + days[j]].max # Compare resting today even if we are not forced to vs not resting
  end

  days = new_days + [days[0]] # We add the case where we are forced to rest for the current day
end

puts days.max