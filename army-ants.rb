gets.strip.split.map(&:to_i)

ants = []
gets.strip.each_char do |c|
  ants << [c, "R"]
end
ants.reverse!  # The first group needs to be reversed

gets.strip.each_char do |c|
  ants << [c, "L"]
end

t = gets.strip.to_i
turn = 0

while turn < t
  turn += 1
  i = 0
  while i < ants.length - 1
    # Two ants are jumping over each others
    if ants[i][1] == "R" && ants[i + 1][1] == "L"
      ants[i], ants[i + 1] = ants[i + 1], ants[i]  # Swap the ants
      i += 1
    end
    i += 1
  end
end

puts ants.map { |ant| ant[0] }.join