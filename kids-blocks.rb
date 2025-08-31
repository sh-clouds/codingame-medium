# Function to get divisors of a number
def get_divisors(n)
  divisors_list = []
  
  # Skip 1, we don't want a single row
  (2..Math.sqrt(n).to_i).each do |i|
    divisors_list << n / i if n % i == 0
  end

  divisors_list
end

# Function to check permutations of pieces
def check_permutations(pieces, size, current)
  # We used all the pieces it's a valid solution
  return true if pieces.sum == 0

  # The current row is full
  current = 0 if current == size

  pieces.each_with_index do |count, i|
    # We add a piece to the current
    if count != 0 && current + i <= size
      pieces[i] -= 1

      result = check_permutations(pieces, size, current + i)

      return true if result
      
      pieces[i] += 1
    end
  end

  false
end

x1 = gets.to_i
x2 = gets.to_i
x3 = gets.to_i

# We can just stack them vertically
if (x1 != 0 && (x2 + x3) == 0) || (x2 != 0 && (x1 + x3) == 0) || (x3 != 0 && (x1 + x2) == 0)
  puts "POSSIBLE"
  exit
end

# Check all the row sizes that could make us use all the pieces
get_divisors(x1 + x2 * 2 + x3 * 3).each do |size|
  if check_permutations([0, x1, x2, x3], size, 0)
    puts "POSSIBLE"
    exit
  end
end

puts "NOT POSSIBLE"
