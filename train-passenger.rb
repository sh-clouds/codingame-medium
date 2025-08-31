start = gets.chomp
end_station = gets.chomp
n = gets.to_i
links = Hash.new { |hash, key| hash[key] = [] }

n.times do
  station1, station2 = gets.chomp.split
  links[station1] << station2
  links[station2] << station1
end


to_check = [[start, {}]]

loop do
  new_check = []

  to_check.each do |info|
    position, history = info

    # Don't return to a station we have already been
    next if history.key?(position)

    # Add the station to the history
    history[position] = true

    # Did we reach the target station
    if position == end_station
      puts history.keys.join(" > ")
      exit
    end

    # Check all the stations we can from current location
    links[position].each do |link|
      new_check << [link, history.dup]
    end
  end

  to_check = new_check
end
