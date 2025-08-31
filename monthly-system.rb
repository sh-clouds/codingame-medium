# Define a constant for the months mapping
MONTHS = {
  "Jan" => "0", "Feb" => "1", "Mar" => "2", "Apr" => "3", "May" => "4", "Jun" => "5",
  "Jul" => "6", "Aug" => "7", "Sep" => "8", "Oct" => "9", "Nov" => "A", "Dec" => "B"
}

sum = 0
answer = ""

# Read the number of inputs
N = gets.to_i
N.times do
  number = ""

  # Read each input and split into chunks of 3 characters
  gets.strip.chars.each_slice(3) do |string|
    number += MONTHS[string.join]
  end

  # Convert the input to a number in base 10 and add it to the sum
  sum += number.to_i(12)
end

# Convert the sum to base 12 and replace each digit by the month
sum.to_s(12).upcase.chars.each do |character|
  answer += MONTHS.key(character)
end

puts answer