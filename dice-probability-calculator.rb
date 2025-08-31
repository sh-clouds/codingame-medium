require 'set'

def dice(number)
  if number.is_a?(Array)
    number = number[0]
  end
  (1..number).to_a
end

def multiply(sequence_one, sequence_two)
  sequence_one.product(sequence_two).map { |a, b| a * b }
end

def add(sequence_one, sequence_two)
  sequence_one.product(sequence_two).map { |a, b| a + b }
end

def subtract(sequence_one, sequence_two)
  sequence_one.product(sequence_two).map { |a, b| a - b }
end

def greater_than(sequence_one, sequence_two)
  sequence_one.product(sequence_two).map { |a, b| (a > b ? 1 : 0) }
end

def tokenize(expression)
  tokens = []
  number = ''
  expression.each_char do |char|
    if char =~ /\d/
      number += char
    else
      if !number.empty?
        tokens << number.to_i
        number = ''
      end
      tokens << char
    end
  end
  tokens << number.to_i unless number.empty?
  tokens
end

def postfix(tokens)
  precedence = { 'd' => 4, '*' => 3, '+' => 2, '-' => 2, '>' => 1 }
  output = []
  operators = []
  tokens.each do |token|
    if token.to_s =~ /\A\d+\z/
      output << [token]
    elsif precedence.key?(token)
      while !operators.empty? && operators.last != '(' && precedence[operators.last] >= precedence[token]
        output << operators.pop
      end
      operators << token
    elsif token == '('
      operators << token
    elsif token == ')'
      while !operators.empty? && operators.last != '('
        output << operators.pop
      end
      operators.pop if !operators.empty? && operators.last == '('
    end
  end
  output.concat(operators.reverse)
end

def evaluate(reverse_polish_notation)
  operators = { 'd' => [1, method(:dice)], '*' => [2, method(:multiply)], '+' => [2, method(:add)], '-' => [2, method(:subtract)], '>' => [2, method(:greater_than)] }
  stack = []
  reverse_polish_notation.each do |token|
    if operators.key?(token[0])
      num_args, function = operators[token[0]]
      arguments = []
      num_args.times { arguments << stack.pop }
      stack << function.call(*arguments.reverse)
    else
      stack << token
    end
  end
  stack
end

expression = gets.chomp
tokens = tokenize(expression)
reverse_polish_notation = postfix(tokens)
result = evaluate(reverse_polish_notation)

count = result[0].each_with_object(Hash.new(0)) { |key, hash| hash[key] += 1 }
total = count.values.sum
count.sort.each do |key, value|
  
  number = value.to_f / total * 100
  formatted_string = sprintf("%.2f", number)
  puts "#{key} #{formatted_string}"
end