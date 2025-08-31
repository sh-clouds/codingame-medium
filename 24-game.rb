def search(values)
  return (values[0] - 24).abs < 0.0000001 if values.size == 1

  values.each_with_index do |value_i, i|
    values.each_with_index do |value_j, j|
      next if i == j

      ['+', '-', '*', '/'].each do |operator|
        result = 0.0
        case operator
        when '+'
          result = value_i + value_j
        when '-'
          result = value_i - value_j
        when '*'
          result = value_i * value_j
        when '/'
          next if value_j.zero?
          result = value_i / value_j
        end

        new_values = [result]
        values.each_with_index do |value_k, k|
          new_values << value_k if k != i && k != j
        end
        return true if search(new_values)
      end
    end
  end
  false
end


input_values = []
4.times do
  input_values << gets.to_f
end
puts search(input_values)
