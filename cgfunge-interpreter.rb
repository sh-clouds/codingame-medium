# Read the number of lines of code from standard input
number_of_lines = gets.to_i
code = []
number_of_lines.times do
    code << gets.chomp
end

# Log the code array
#puts code.inspect

MOVES = { "^" => [0, -1], "v" => [0, 1], "<" => [-1, 0], ">" => [1, 0] }
direction = ">"
stack = []
skip = false
string_mode = 0
x = 0
y = 0

loop do
    c = code[y][x] || " "

    if skip
        skip = false
    elsif c =~ /\d/
        stack << c.to_i
    elsif string_mode == 1 && c != '"'
        stack << c.ord
    elsif ["+", "-", "*", "X"].include?(c)
        right = stack.pop
        left = stack.pop

        case c
        when "+"
            stack.push(left + right)
        when "-"
            stack.push(left - right)
        when "*"
            stack.push(left * right)
        when "X"
            stack.push(right, left)
        end
    elsif ["<", ">", "^", "v"].include?(c)
        direction = c
    else
        case c
        when '"'
            string_mode ^= 1
        when "_"
            direction = (stack.pop == 0) ? ">" : "<"
        when "|"
            direction = (stack.pop == 0) ? "v" : "^"
        when "C"
            print stack.pop.chr
        when "D"
            stack << stack.last
        when "E"
            break
        when "I"
            print stack.pop
        when "P"
            stack.pop
        when "S"
            skip = true
        end
    end

    mx, my = MOVES[direction]
    x += mx
    y += my
end