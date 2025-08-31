# Function to check if a number is prime
def is_prime(num)
  return false if num <= 1
  return true if num == 2
  return false if num.even?

  sqrt_num = Math.sqrt(num)

  (3..sqrt_num).step(2) do |i|
    return false if num % i == 0
  end

  true
end

# Function to find the next pair of prime twins starting from x
def find_next_prime_twins(x)
  # Start from the next odd number
  x += 1 if x.even?

  loop do
    return x + 1 if is_prime(x) && is_prime(x + 2) # Found the twin primes

    x += 2 # Move to the next odd number
  end
end

# Generate the alphabet with the key
def get_alphabet(key)
  alphabet = {}
  value = key

  ('A'..'Z').each do |letter|
    alphabet[letter] = (key + value).to_s(16).upcase

    value = find_next_prime_twins(key + value + 1)
  end

  alphabet
end

start_time = Time.now

operation = gets.strip
key = gets.to_i
message = gets.strip
alphabet = get_alphabet(key)

# We are encoding
if operation == "ENCODE"
  if message !~ /^[A-Z ]+$/
    puts "ERROR !!"
  else
    alphabet[" "] = ""

    output = message.chars.map { |c| alphabet[c] }

    puts output.join("G")
  end
# We are decoding
else
  # Check that all the characters are allowed and that we don't have a substring of G of odd length > 1
  if message !~ /^[0-9A-G]+$/ || message =~ /(?<!G)(G{2})+G(?!G)/
    puts "ERROR !!"
  else
    alphabet = alphabet.invert.merge(" " => " ")
    letters = message.gsub("GG", "G G").split("G").reject(&:empty?)

    decoded = letters.map { |letter| alphabet[letter] }.join("")

    puts decoded
  end
end

error_log_time = Time.now - start_time
