# Generate the list of all sums & multiplications that can be made with the 9 digits
digits = (1..9).to_a
turn = 1

s = gets.to_i
p = gets.to_i

possible_sum = {}
possible_mul = {}

digits.each do |digit1|
  digits.each do |digit2|
    next if digit2 < digit1

    possible_sum[digit1 + digit2] ||= {}
    possible_sum[digit1 + digit2]["#{digit1},#{digit2}"] = 1

    possible_mul[digit1 * digit2] ||= {}
    possible_mul[digit1 * digit2]["#{digit1},#{digit2}"] = 1
  end
end

impossible_burt = []
impossible_sarah = []

loop do
  possible_sum.each do |sum, list|
    # Burt can remove all the pair that were the unique solution for Sarah
    impossible_burt.each { |pair| list.delete(pair) }

    next if list.size > 1

    # Burt knows for sure what the 2 digits are
    if s == sum
      puts "(#{list.keys.first}) BURT #{turn}"
      exit
    end

    # It's a unique solution, Sarah will know it can't the right one
    impossible_sarah << list.keys.first unless list.empty?

    possible_sum.delete(sum)
  end

  impossible_burt = []

  possible_mul.each do |mul, list|
    # Sarah can remove all the pair that were the unique solution for Burt
    impossible_sarah.each { |pair| list.delete(pair) }

    next if list.size > 1

    # Sarah knows for sure what the 2 digits are
    if p == mul
      puts "(#{list.keys.first}) SARAH #{turn}"
      exit
    end

    # It's a unique solution, Burt will know it can't the right one
    impossible_burt << list.keys.first unless list.empty?

    possible_mul.delete(mul)
  end 

  # Neither Burt nor Sarah can eliminate more pairs, the two digits can't be guessed
  if impossible_burt.empty? && impossible_sarah.empty?
    puts "IMPOSSIBLE"
    exit
  end

  impossible_sarah = []

  turn += 1
end