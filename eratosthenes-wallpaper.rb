# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
def sieve_of_eratosthenes(limit)
  # Initialise the sieve array
  sieve_array = [1] * (limit - 1)
  
  (2...limit).each do |i|
    # This number is still in the sieve, remove all its multiples
    if sieve_array[i - 2] == 1
      (i * 2...limit).step(i) do |j|
        sieve_array[j - 2] = 0
      end
    end
  end
  
  sieve_array.each_with_index.select { |value, index| value == 1 }.map { |_, index| index + 2 }
end

# Get the prime factors of number sorted in ascending order
def prime_factors(number, primes)
  factors = []
  index = 0

  while number >= 2
    if number % primes[index] == 0
      factors << primes[index]
      number /= primes[index]
    else
      # If we are out of primes to check, the number left is a prime, we are done
      if index + 1 == primes.length
        factors << number
        break
      end
      index += 1
    end
  end

  factors
end

width, height, number = gets.strip.split.map(&:to_i)

y = 0
line = ""
primes = sieve_of_eratosthenes(Math.sqrt(10**9).to_i)

while y < height
  number_with_factors = "#{number}=" + prime_factors(number, primes).join("*")

  if line != ""
    # Not enough space left in current line to add the new number
    if line.length + number_with_factors.length + 1 > width
      puts line.ljust(width, "-")
      y += 1
      line = ""
    else
      # We just add the number to the current line
      line += "," + number_with_factors
      number += 1
      next
    end
  end

  # Current line is empty & there's enough space for the number
  if number_with_factors.length <= width
    line += number_with_factors
    number += 1
  else
    # We can't add number anymore, finish the wallpaper with empty lines
    (height - y).times { puts "-" * width }
    break
  end
end