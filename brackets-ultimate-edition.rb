PAIRINGS = { '(' => '()', ')' => '()', '{' => '{}', '}' => '{}', '[' => '[]', ']' => '[]', '<' => '<>', '>' => '<>' }

def count(expression)
  return 0 if expression.empty?

  matches = PAIRINGS[expression[0]]
  possible_pairings = (1...expression.length).select { |i| matches.include?(expression[i]) }

  lowest_cost = 100000
  if possible_pairings.length.odd?
    possible_pairings.each_slice(2) do |pair|
      cost = (expression[0] != matches[0] ? 1 : 0) + (expression[pair[0]] != matches[1] ? 1 : 0)

      sub_expression_cost = count(expression[1...pair[0]])
      next if sub_expression_cost == -1

      cost += sub_expression_cost
      sub_expression_cost = count(expression[(pair[0] + 1)..-1])
      next if sub_expression_cost == -1

      lowest_cost = [lowest_cost, cost + sub_expression_cost].min
    end
  end

  lowest_cost == 100000 ? -1 : lowest_cost
end

gets.to_i.times do
  puts count(gets.chomp.chars.select { |c| '(){}[]<>'.include?(c) })
end