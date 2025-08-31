n = gets.to_i
list_a = gets.split.map(&:to_i)
list_b = gets.split.map(&:to_i)

operations = []
(0...n-1).each do |index|
  while list_a[index] != list_b[index]
    if list_a[index] > list_b[index]
      amount = list_a[index] - list_b[index]
      list_a[index] = list_b[index]
      list_a[index + 1] += amount
      operations << [index + 1, 1, amount]
    else
      get_index = index + 1
      needed = list_b[index]
      have = list_a[index] + list_a[get_index]
      while have < needed
        needed += list_b[get_index]
        get_index += 1
        have += list_a[get_index]
      end
      if have == needed
        amount = list_a[get_index]
      else
        amount = needed - (have - list_a[get_index])
      end
      list_a[get_index] -= amount
      list_a[get_index - 1] += amount
      operations << [get_index + 1, -1, amount]
    end
  end
end

puts operations.length
operations.each { |op| puts op.join(' ') }