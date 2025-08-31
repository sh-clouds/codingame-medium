number_of_lines = gets.to_i
code_input = ''
number_of_lines.times { code_input += gets }
$stderr.puts 0, code_input

# Remove escaped quotes
code_input = code_input.gsub(/(?<!\\)(\\\\)*\\"/, '')
$stderr.puts 1, code_input

# Remove comments (should maybe be merged with previous)
code_input = code_input.gsub(/"[^"]*?"/, '')
$stderr.puts 2, code_input

# Remove all non-brackets char
code_input = code_input.gsub(/[^\[\]\(\)\{\}]/, '')
$stderr.puts 3, code_input

if code_input == ""
    puts "No brackets"
else
    # Remove inner valid brackets
    while code_input != (code_input = code_input.gsub(/\(\)|\[\]|\{\}/, ''))
        $stderr.puts 4, code_input
    end
    $stderr.puts 5, code_input

    if code_input == ""
        puts "Valid"
    else
        puts "Invalid"
    end
end