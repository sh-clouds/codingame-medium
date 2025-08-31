data = Array.new(readline.to_i) { readline.split('') }
test = lambda do |stack, character|
  case character
  when '(', ')'
    stack.last == '(' ? stack.pop : stack.push('(')
  when '[', ']'
    stack.last == '[' ? stack.pop : stack.push('[')
  when '{', '}'
    stack.last == '{' ? stack.pop : stack.push('{')
  when '<', '>'
    stack.last == '<' ? stack.pop : stack.push('<')
  end
  stack
end

data.each do |data_array|
  puts (data_array.reduce([], &test).length == 0)
end