def next_gen_pattern(pattern, binary)
  next_pattern = ""
  pattern = pattern.gsub(".", "0").gsub("@", "1")
  pattern.length.times do |i|
    neighborhood = pattern[i]
    if i == 0
      neighborhood = pattern[-1] + neighborhood
    else
      neighborhood = pattern[i - 1] + neighborhood
    end
    if i == pattern.length - 1
      neighborhood += pattern[0]
    else
      neighborhood += pattern[i + 1]
    end
    index = 7 - neighborhood.to_i(2)
    next_pattern += binary[index]
  end
  next_pattern.gsub("0", ".").gsub("1", "@")
end

R = gets.to_i
N = gets.to_i
pattern = gets.chomp

binary = R.to_s(2).rjust(8, "0")
STDERR.puts binary
N.times do
  puts pattern
  pattern = next_gen_pattern(pattern, binary)
end