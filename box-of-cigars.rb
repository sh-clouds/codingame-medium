def check(current_index, difference)
  (current_index + 1...$number_of_elements).each do |i|
    temporary_difference = $array[i] - $array[current_index]
    if temporary_difference == difference
      $temporary_result += 1
      check(i, difference)
    elsif temporary_difference > difference
      return
    end
  end
end

def remove_duplicates
  unique_array = []
  (0...$number_of_elements - 1).each do |i|
    unique_array << $array[i] if $array[i] != $array[i + 1]
  end
  unique_array << $array[$number_of_elements - 1]
  unique_array.each_with_index do |value, index|
    $array[index] = value
  end
  $number_of_elements = unique_array.size
end

# Main execution starts here
$number_of_elements = gets.to_i
$array = Array.new($number_of_elements) { gets.to_i }
remove_duplicates
maximum_result = 0

(0...$number_of_elements - 1).each do |i|
  (i + 1...$number_of_elements).each do |j|
    $temporary_result = 2
    check(j, $array[j] - $array[i])
    maximum_result = [maximum_result, $temporary_result].max
  end
end

puts maximum_result