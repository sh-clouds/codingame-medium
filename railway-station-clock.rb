time_input = gets.chomp  # Reading input from standard input

def in_seconds(time_string)
  total_seconds = 0
  time_part, meridiem = time_string.split(' ')
  hours, minutes, seconds_part = time_part.split(':').map(&:to_i)
  hours = hours % 12
  if meridiem == 'AM' && hours < 8
    total_seconds = (16 + hours) * 3600 + minutes * 60 + seconds_part
  elsif meridiem == 'AM' && hours >= 8
    total_seconds = (hours - 8) * 3600 + minutes * 60 + seconds_part
  else
    total_seconds = (hours + 4) * 3600 + minutes * 60 + seconds_part
  end
  total_seconds
end

def in_time(total_seconds)
  hours_total = total_seconds / 3600
  if hours_total < 4
    meridiem = 'AM'
    hours = hours_total + 8
  elsif hours_total >= 16
    meridiem = 'AM'
    hours = hours_total - 16
    hours = 12 if hours == 0
  else
    meridiem = 'PM'
    hours = hours_total - 4
    hours = 12 if hours == 0
  end
  remaining_seconds = total_seconds % 3600
  minutes = remaining_seconds / 60
  seconds_remaining = remaining_seconds % 60
  "#{hours}:#{minutes.to_s.rjust(2, '0')}:#{seconds_remaining.to_s.rjust(2, '0')} #{meridiem}"
end

seconds_value = in_seconds(time_input)
seconds_to_add = seconds_value / 239
time_output = in_time(seconds_value + seconds_to_add)
puts time_output