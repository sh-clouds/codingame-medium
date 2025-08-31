N = gets.to_i
R = gets.to_i
prizes = []
N.times do
  prizes << gets.to_i
end

day = Array.new(R + 1) { [0, []] }

# Check all the prizes starting from the end
(N - 1).downto(0) do |i|
  new_day = []

  # Check the best prizes if we reach this day with j days since we rested
  (1..R).each do |j|
    # It's best to rest the current day
    if day[0][0] > prizes[i] + day[j][0]
      new_day[j - 1] = day[0]
    # It's best to participate the current day
    else
      new_day[j - 1] = [prizes[i] + day[j][0], day[j][1] + [i + 1]]
    end
  end
  
  day = new_day + [day[0]] # We add the case where we are forced to rest for the current day
end

puts day[0][1].reverse.join(">")