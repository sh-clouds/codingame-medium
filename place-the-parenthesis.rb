def bruteforce(equation)
  left, right = equation.split("=")
  if eval(left) == right.to_i
    return equation
  end
  
  left_terms = left.split(/(\+|\*|\/|(?<=\w)-)/).reject(&:empty?)
  # So left_terms is [term, operator, term, operator etc.]
  number_of_terms = (left_terms.length + 1) / 2
  (0...number_of_terms).each do |i|
    left_terms.insert(2 * i, "(")
    (i + 1...number_of_terms).each do |j|
      left_terms.insert(2 * (j + 1), ")")
      joined = left_terms.join
      if eval(joined) == right.to_i
        return "#{joined}=#{right}"
      end
      left_terms.delete(")")
    end
    left_terms.delete("(")
  end
end

(0...gets.to_i).each do
  equation = gets.chomp
  puts bruteforce(equation)
end

