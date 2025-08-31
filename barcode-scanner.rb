def parse_ean13(bits)
  side_guard, mid_guard = '101', '01010'
  invalid_scan = 'INVALID SCAN'
  return invalid_scan unless bits.length == 95 &&
                             bits.start_with?(side_guard) &&
                             bits.end_with?(side_guard) &&
                             bits[45, 5] == mid_guard

  left_digits = []
  middle_digits = []
  right_digits = []
  f_values = [0, 11, 13, 14, 19, 25, 28, 21, 22, 26]

  [13, 25, 19, 61, 35, 49, 47, 59, 55, 11].each do |i|
    left_digits << i.to_s(2).rjust(7, '0')
    right_digits << (127 - i).to_s(2).rjust(7, '0')
    middle_digits << right_digits.last.reverse
  end

  bits = bits[3, 42] + bits[50, 42]
  if !left_digits.include?(bits[0, 7])
    bits = bits.reverse
    return invalid_scan unless left_digits.include?(bits[0, 7])
  end

  f = 0
  decoded_digits = [left_digits.index(bits[0, 7])]

  (1..5).each do |i|
    segment = bits[i * 7, 7]
    f *= 2
    if left_digits.include?(segment)
      decoded_digits << left_digits.index(segment)
    elsif middle_digits.include?(segment)
      decoded_digits << middle_digits.index(segment)
      f += 1
    else
      return invalid_scan
    end
  end

  return invalid_scan unless f_values.include?(f)
  decoded_digits.insert(0, f_values.index(f))

  (6..11).each do |i|
    segment = bits[i * 7, 7]
    return invalid_scan unless right_digits.include?(segment)
    decoded_digits << right_digits.index(segment)
  end

  return invalid_scan unless decoded_digits.each_with_index.sum { |j, i| (1 + 2 * (i & 1)) * j } % 10 == 0

  decoded_digits.join
end

puts parse_ean13(gets.chomp)