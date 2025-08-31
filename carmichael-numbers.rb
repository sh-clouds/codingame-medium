# Check if a number n is a prime number
def prime_check(number)
  return 0 if number == 1

  (2..Math.sqrt(number).to_i).each do |i|
    return 0 if number % i == 0
  end

  1
end

# Get the prime factors of number
def prime_factors(number)
  factors = {}
  divisor = 2

  while number >= 2
    if number % divisor == 0
      factors[divisor] = 1
      number /= divisor
    else
      divisor += 1
    end
  end
  factors
end

number = gets.to_i

factors = prime_factors(number)

# It's a prime number
if factors.length == 1
    puts "NO"  
    exit() 
end        

factors.each do |factor, weight|
    if (number - 1) % (factor - 1) != 0 
        puts "NO"  
        exit() 
    end
end

puts "YES"