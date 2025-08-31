v = gets.to_i
n = gets.to_i

products = []

n.times do
  matches = gets.chomp.match(/(.*) ([0-9]+)/)
  products << matches[2].to_i
end

# Sort by most expensive to cheapest
products.sort!.reverse!

count = 0

def search_solution(index, total, products, count, v, n)
  # We reached the voucher value
  if total == v
    count += 1
    return count
  end

  # Sum is too much or no product left to add
  return count if total > v || index == n

  # We add the product 0-3 times
  (0..3).each do |i|
    count = search_solution(index + 1, total + (products[index] * i), products, count, v, n)
  end

  count
end

count = search_solution(0, 0, products, count, v, n)

puts count