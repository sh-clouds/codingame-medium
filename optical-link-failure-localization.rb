links = gets.chomp.to_i
mtrails = gets.chomp.to_i
failures = gets.chomp.to_i
alarm_code = gets.chomp
left_side = []
right_side = []

(0...links).each do |index|
  row = gets.chomp
  if failures == 2
    left_side.each_with_index do |value, key|
      if (value.to_i(2) | row.to_i(2)) == alarm_code.to_i(2)
        right_side << "#{key} #{index}"
      end
    end
    left_side << row
  elsif row == alarm_code
    right_side << index.to_s
  end
end

if right_side.length == 1
  puts right_side[0]
else
  puts "AMBIGUOUS"
end