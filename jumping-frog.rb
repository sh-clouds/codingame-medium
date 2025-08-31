def solve(hash_string, index)
  history = {}

  longest_jump = 0
  hash_string = hash_string[0...index] + '0' + hash_string[index + 1..-1]

  return history[[hash_string, index]] if history.key?([hash_string, index])

  $global_jumps[index].each do |index_jump|
    if hash_string[index_jump] == '1'
      result = 1 + solve(hash_string, index_jump)

      longest_jump = result if result > longest_jump
    end
  end

  history[[hash_string, index]] = longest_jump
  return longest_jump
end


n = gets.to_i
pond = Array.new(n) { gets.chomp }

 STDERR.puts pond.inspect

xd = gets.to_i
yd = gets.to_i

hash_string = '0' * (n * n)

# Pre-compute the possible jumps
$global_jumps = {}
(0...n).each do |y|
  (0...n).each do |x|
    index = y * n + x
    if pond[y][x] == '#'
      $global_jumps[index] ||= []
      $global_jumps[index] << index - 1 if x > 0 && pond[y][x - 1] == '#'
      $global_jumps[index] << index - 2 if x > 1 && pond[y][x - 2] == '#'
      $global_jumps[index] << index + 1 if x < n - 1 && pond[y][x + 1] == '#'
      $global_jumps[index] << index + 2 if x < n - 2 && pond[y][x + 2] == '#'

      $global_jumps[index] << index - n if y > 0 && pond[y - 1][x] == '#'
      $global_jumps[index] << index - 2 * n if y > 1 && pond[y - 2][x] == '#'
      $global_jumps[index] << index + n if y < n - 1 && pond[y + 1][x] == '#'
      $global_jumps[index] << index + 2 * n if y < n - 2 && pond[y + 2][x] == '#'

      $global_jumps[index] << index - n - 1 if x > 0 && y > 0 && pond[y - 1][x - 1] == '#'
      $global_jumps[index] << index - n + 1 if x < n - 1 && y > 0 && pond[y - 1][x + 1] == '#'
      $global_jumps[index] << index + n + 1 if x < n - 1 && y < n - 1 && pond[y + 1][x + 1] == '#'
      $global_jumps[index] << index + n - 1 if x > 0 && y < n - 1 && pond[y + 1][x - 1] == '#'

      hash_string[index] = '1'
    end
  end
end

if hash_string == '1' * (n * n)
  puts n * n
else
  puts 1 + solve(hash_string, yd * n + xd)
end

