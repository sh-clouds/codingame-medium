l = gets.to_i
n = gets.to_i
rods = []

def get_answer(length, rods)
  #items[0]: length and items[1]: value
  sums = Array.new(length + 1, 0)
  rods.each do |item|
    (1..length).each do |j|
      if j - item[0] >= 0
        sums[j] = [sums[j], sums[j - item[0]] + item[1]].max
      end
    end
  end
  sums[length]
end

n.times do
  ln, val = gets.split.map(&:to_i)
  rods << [ln, val]
end

puts get_answer(l, rods)