lists = {}

n = gets.to_i
n.times do
  p = gets.to_i

  current = 0
  
  # Find the current highest sequence where we can add the number
  lists.each do |number, count|
    if number < p && count > current
      current = count
    end
  end
  
  lists[p] = [lists[p] || 0, current + 1].max
end

puts lists.values.max