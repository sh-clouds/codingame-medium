# Initialize the alphabet array
alphabet = ('a'..'z').to_a
minified_variables = {}
code = ""

# Read the number of lines to process
number_of_lines = gets.to_i
number_of_lines.times do
  code += gets.chomp
end

# Find all the variables to minify
matches = code.scan(/\$([^\$]*)\$/)

matches.each do |match|
  variable = match[0]
  # This variable hasn't already been minified
  unless minified_variables.key?(variable)
    minified_variables[variable] = alphabet.shift

    code.gsub!("$#{variable}$", "$#{minified_variables[variable]}$")
  end
end

# Replace any space character except between apostrophes, we assume there are no nested apostrophes and no unclosed apostrophes
puts code.gsub(/\s+(?=(?:[^\']*[\'][^\']*[\'])*[^\']*$)/, "")
