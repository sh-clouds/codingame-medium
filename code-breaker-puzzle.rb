alpha = gets.chomp
msg   = gets.chomp
word  = gets.chomp
length_of_alpha = alpha.length

(0...length_of_alpha).each do |a|
  (0...length_of_alpha).each do |b|
    result = ""
    msg.each_char do |m|
      result += alpha[((alpha.index(m) + a) * b) % length_of_alpha]
    end

    if result.include?(word)
      puts result
      exit(0)
    end
  end
end