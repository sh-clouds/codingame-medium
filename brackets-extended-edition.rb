number_of_expressions = gets.to_i
expressions = Array.new(number_of_expressions) { gets.chomp.chars }

def valid_expression(stack, character)
  case character
  when '(', ')'
    if stack.last == '('
      stack.pop
    else
      stack.push('(')
    end
  when '[', ']'
    if stack.last == '['
      stack.pop
    else
      stack.push('[')
    end
  when '<', '>'
    if stack.last == '<'
      stack.pop
    else
      stack.push('<')
    end
  when '{', '}'
    if stack.last == '{'
      stack.pop
    else
      stack.push('{')
    end
  end
  stack
end

expressions.each do |expression|
  puts valid_expression(expression.reduce([], &method(:valid_expression)), '').empty?
end
