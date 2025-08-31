N = gets.to_i
inputs = gets.strip.split.map { |input| [input, {}] }

while inputs.length > 1 do
  index = 0

  # Find the first operation
  while !["+", "-", "/", "*"].include?(inputs[index][0]) do
    index += 1
  end

  left, right, operator = inputs.slice(index - 2, 3)

  p_right = false
  p_left = false

  # Check if left or right requires parentheses
  if operator[0] != "+" && (right[1].key?("+") || right[1].key?("-"))
    p_right = true
  end
  if operator[0] == "/" && (right[1].key?("/") || right[1].key?("*"))
    p_right = true
  end
  if (operator[0] == "*" || operator[0] == "/") && (left[1].key?("+") || left[1].key?("-"))
    p_left = true
  end

  expression = "#{p_left ? '(' : ''}#{left[0]}#{p_left ? ')' : ''} #{operator[0]} #{p_right ? '(' : ''}#{right[0]}#{p_right ? ')' : ''}"

  # The operators that are used in the expression
  operators = (p_left ? {} : left[1]).merge(p_right ? {} : right[1]).merge({ operator[0] => 1 })

  inputs[index - 2, 3] = [[expression, operators]]
end

puts inputs[0][0]