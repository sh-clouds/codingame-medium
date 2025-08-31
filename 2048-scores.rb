# Get the total score we got by creating the number n
def get_score(n)
  score = 0
  power = 0

  while n >= 4
    score += n * (2**power)
    n >>= 1
    power += 1
  end

  score
end

score = 0
moves = -2 # We start with at least 2 numbers

4.times do
  gets.split.each do |value|
    score += get_score(value.to_i)
    moves += value.to_i / 2
  end
end

fours = gets.to_i

score -= fours * 4
moves -= fours

puts "#{score}\n#{moves}\n"