def solver(operations)
  operations = operations.split(" ")

  data_structures = {
    "queue" => {"seq" => [], "check" => []},
    "stack" => {"seq" => [], "check" => []},
    "priority queue" => {"seq" => [], "check" => []}
  }

  operations.each do |operation|
    io = operation[0]
    data = operation[1..-1].to_i
    if io == "i"
      data_structures["queue"]["seq"].insert(0, data)
      data_structures["stack"]["seq"] << data
      data_structures["priority queue"]["seq"] << data
      data_structures["priority queue"]["seq"].sort!
    elsif io == "o"
      data_structures.each_value do |structure|
        begin
          structure["check"] << (data == structure["seq"].pop)
        rescue
          structure["check"] << false
        end
      end
    end
  end

  result = data_structures.select { |_, v| v["check"].all? }.keys
  if result.length > 1
    return "unsure"
  elsif result.length == 0
    return "mystery"
  end
  return result[0]
end

number_of_cases = gets.to_i
number_of_cases.times do
  puts solver(gets.chomp)
end