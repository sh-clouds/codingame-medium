budget_left = []
budget_calculated = []
oods_left = n = gets.to_i
cost_left = gets.to_i

n.times do
  budget_left << gets.to_i
  budget_calculated << 0
end

while oods_left > 0 do
  each_pay = (cost_left / oods_left).floor
  n.times do |i|
    next if budget_left[i] == 0
    
    if budget_left[i] <= each_pay
      oods_left -= 1
      budget_calculated[i] += budget_left[i]
      cost_left -= budget_left[i]
      budget_left[i] = 0
    else
      budget_calculated[i] += each_pay
      cost_left -= each_pay
      budget_left[i] -= each_pay
    end
    
    break if cost_left == 0
  end
  
  if cost_left < oods_left
    (n - 1).downto(0) do |i|
      break if cost_left == 0
      if budget_left[i] > 0
        budget_calculated[i] += 1
        cost_left -= 1
      end
    end
  end
  
  break if cost_left == 0
end

if oods_left == 0 && cost_left > 0
  puts "IMPOSSIBLE"
else
  budget_calculated.sort.each do |b|
    puts b
  end
end
the-gift
