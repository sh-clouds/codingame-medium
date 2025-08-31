# Minimax algorithm
def solve(values, depth, alpha, beta)
  $explored += 1

  # We are on the deepest depth
  return values.pop if depth == $D

  value = (depth % 2 == 0) ? -Float::INFINITY : Float::INFINITY

  length = values.length / $B

  (0...$B).each do |i|
    # We use the max value
    if depth % 2 == 0
      value = [value, solve(values[i * length, length], depth + 1, alpha, beta)].max

      return value if value >= beta # Cutoff beta

      alpha = [alpha, value].max
    # We use the min value
    else
      value = [value, solve(values[i * length, length], depth + 1, alpha, beta)].min

      return value if alpha >= value # Cutoff alpha

      beta = [beta, value].min
    end
  end

  value
end

$D, $B = gets.split.map(&:to_i)
values = gets.strip.split.map(&:to_i)

$explored = 0

puts "#{solve(values, 0, -Float::INFINITY, Float::INFINITY)} #{$explored}"