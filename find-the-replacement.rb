x = gets.chomp.chars
y = gets.chomp
replace = {}
x.each_with_index do |c, i|
  if replace.key?(c) && replace[c] != y[i]
    puts "CAN'T"
    exit
  else
    replace[c] = y[i]
  end
end
changes = replace.select { |k, v| k != v }
if changes.empty?
  puts "NONE"
end
changes.each { |from_char, to_char| puts "#{from_char}->#{to_char}" }