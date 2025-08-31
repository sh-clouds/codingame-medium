require 'set'

def fizzbuzzer(number)
  number_string = number.to_s
  substring = ""
  substring += "Fizz" * number_string.count("3")
  k = number
  while k % 3 == 0
    substring += "Fizz"
    k /= 3
  end
  
  substring += "Buzz" * number_string.count("5")
  k = number
  while k % 5 == 0
    substring += "Buzz"
    k /= 5
  end

  return number if substring.empty?
  substring
end

default_dict = Hash.new { |hash, key| hash[key] = [] }

grand_pairs = (1..1000).map { |num| [fizzbuzzer(num), num] }
grand_pairs.each do |pair|
  a, b = pair
  default_dict[a] << b
end

data_hash = default_dict.transform_keys(&:to_s).transform_values(&:first)

n = gets.to_i
n.times do
  row = gets.chomp
  puts data_hash.fetch(row, "ERROR")
end