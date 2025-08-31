# Generate the hash of the string
# BBBSAAA & rrrmppp => AAABCCC
# SBSAS & mrmpm => ABACA
def get_hash(string)
  unique_characters = string.chars.uniq # The characters in the original string in the order of appearance
  replacement_characters = ("A".."Z").to_a[0...unique_characters.length] # The characters we use to replace them

  string.tr(unique_characters.join, replacement_characters.join)
end

number_of_requests = gets.to_i
requests = []
number_of_requests.times do
  requests << get_hash(gets.chomp)
end

answer = Array.new(number_of_requests, 0) # Fill with default values so it's already sorted

number_of_requests.times do |i|
  answer[requests.index(get_hash(gets.chomp))] = i + 1
end

puts answer.join("\n")
