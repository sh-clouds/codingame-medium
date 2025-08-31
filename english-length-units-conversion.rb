def gcd(a, b)
  b != 0 ? gcd(b, a % b) : a
end

conversion = gets.chomp.split(" in ")
n = gets.to_i
relations = {}

n.times do
  matches = gets.chomp.match(/([0-9]+) (.+) = ([0-9]+) (.+)/)
  relations[matches[2]] ||= {}
  relations[matches[4]] ||= {}
  relations[matches[2]][matches[4]] = [matches[1].to_i, matches[3].to_i]
  relations[matches[4]][matches[2]] = [matches[3].to_i, matches[1].to_i]
end

to_check = [[conversion[0], 1, 1]]
checked = {}

until to_check.empty?
  unit, n1, n2 = to_check.pop

  # We reached the desired unit
  break if unit == conversion[1]

  # We already checked this unit
  next if checked[unit]

  checked[unit] = true

  # Test all the relation we know for the current unit
  relations[unit].each do |name, values|
    to_check.push([name, n1 * values[0], n2 * values[1]])
  end
end

# We only want integer so we don't do division, for the output we have to divide by the gcd
gcd_value = gcd(n1, n2)

puts "#{n1 / gcd_value} #{conversion[0]} = #{n2 / gcd_value} #{conversion[1]}"
