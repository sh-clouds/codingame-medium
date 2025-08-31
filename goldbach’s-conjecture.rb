require 'time'

start_time = Time.now

# https://en.wikipedia.org/wiki/Sieve_of_Atkin
def sieve_of_atkin(limit)
    # Initialise the sieve array with false values
    sieve = Array.new(limit + 1, 0)
    primes = {2 => 1, 3 => 1, 5 => 1}

    # Toggle sieve[n] if one of the following is true:
    # A) 4x^2 + y^2 = n is odd and modulo-60 remainder is 1, 13, 17, 29, 37, 41, 49, or 53
    # B) 3x^2 + y^2 = n is odd and modulo-60 remainder is 7, 19, 31, or 43
    # C) 3x^2 - y^2 = n is odd and modulo-60 remainder is 11, 23, 47, or 59

    reminder_a = {1 => nil, 13 => nil, 17 => nil, 29 => nil, 37 => nil, 41 => nil, 49 => nil, 53 => nil}
    reminder_b = {7 => nil, 19 => nil, 31 => nil, 43 => nil}
    reminder_c = {11 => nil, 23 => nil, 47 => nil, 59 => nil}

    (1..Math.sqrt(limit).to_i).each do |x|
        (1..Math.sqrt(limit).to_i).each do |y|
            # A
            n = (4 * x * x) + (y * y)
            if n <= limit && reminder_a.key?(n % 60)
                sieve[n] ^= 1
            end

            # B
            n = (3 * x * x) + (y * y)
            if n <= limit && reminder_b.key?(n % 60)
                sieve[n] ^= 1
            end

            # C
            n = (3 * x * x) - (y * y)
            if x > y && n <= limit && reminder_c.key?(n % 60)
                sieve[n] ^= 1
            end
        end
    end

    # Mark all multiples of squares as non-prime
    (7..limit).each do |r|
        # Take the next number in the sieve list still marked prime
        if sieve[r] != 0
            primes[r] = 1  # Include the number in the results list.

            # Square the number and mark all multiples of that square as non-prime
            (r * r..limit).step(r * r) do |i|
                sieve[i] = 0
            end
        end
    end

    primes
end

n = gets.to_i
numbers = Array.new(n) { gets.to_i }

primes = sieve_of_atkin(numbers.max)

numbers.each do |number|
    # Goldbach’s Conjecture is only for even numbers
    if number.odd?
        puts "OOS"
    else
        count = 0

        # Check all primes up to the half of the number
        primes.keys.each do |prime|
            break if prime > number / 2
            count += 1 if primes.key?(number - prime)
        end

        puts count > 0 ? count : "OOS"
    end
end

# puts Time.now - start_time