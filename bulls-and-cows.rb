possible_answers_list = []

(0..9999).each do |number|
  possible_answers_list << format("%04d", number)
end

def is_rule_applicable(source, guess, bulls, cows)
  true_bulls = 0
  true_cows = 0
  source_bulls = source.chars
  guess_bulls = guess.chars
  source_cows = source.chars
  guess_cows = guess.chars
  
  source_bulls.each_with_index do |char, index|
    if char == guess_bulls[index]
      true_bulls += 1
      source_cows.delete_at(index - true_bulls + 1)
      guess_cows.delete_at(index - true_bulls + 1)
    end
  end
  
  return false if true_bulls != bulls

  source_cows.each do |char|
    true_cows += 1 if guess_cows.include?(char)
  end

  return false if true_cows != cows

  true
end

n = gets.to_i
n.times do
  guess, bulls, cows = gets.split
  bulls = bulls.to_i
  cows = cows.to_i

  possible_answers_list.select! { |x| is_rule_applicable(x, guess, bulls, cows) }
end

puts possible_answers_list[0]