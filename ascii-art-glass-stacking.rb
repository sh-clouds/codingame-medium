number_of_rows = gets.to_i
pattern = [" *** ", " * * ", " * * ", "*****"]
current_row = 1

begin
  number_of_rows -= current_row
  current_row += 1
end while number_of_rows >= current_row

$stderr.puts(current_row)

(1...current_row).each do |row_index|
  (0...4).each do |pattern_index|
    row_string = ""
    (0...row_index).each do |repeat_index|
      row_string += pattern[pattern_index] + (row_index == current_row - 1 && repeat_index == row_index - 1 ? "" : " ")
    end
    puts row_string.rjust(row_index * 6 + (current_row - row_index - 1) * 3 - (row_index == current_row - 1 ? 1 : 0)).ljust(5 * (current_row - 1) + (current_row - 2))
  end
end