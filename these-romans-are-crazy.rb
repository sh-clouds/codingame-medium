# Define a constant for Roman numeral mapping
ROMAN = { 1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I" }

# Convert an integer to its Roman-numeral representation
def convert_to_roman(number)
  roman_representation = ""

  ROMAN.each do |value, symbol|
    while value <= number
      roman_representation += symbol
      number -= value
    end
  end

  roman_representation
end

# Convert a Roman-numeral to its integer representation
def convert_to_integer(roman)
  integer_representation = 0

  ROMAN.each do |value, symbol|
    while roman.start_with?(symbol)
      integer_representation += value
      roman = roman[symbol.length..-1]
    end
  end

  integer_representation
end

# Read input, convert to integer, and then to Roman numeral
input1 = gets.chomp
input2 = gets.chomp
result = convert_to_roman(convert_to_integer(input1) + convert_to_integer(input2))
puts result