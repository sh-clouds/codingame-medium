require 'set'

$memo = {}

def tilings_recursive(uncovered)
  if uncovered.size.odd?
    return 0
  end
  if uncovered.empty?
    return 1
  end
  unless $memo.key?(uncovered)
    i, j = uncovered.min
    $memo[uncovered] = tilings_recursive(uncovered - [[i, j], [i, j + 1]]) + tilings_recursive(uncovered - [[i, j], [i + 1, j]])
  end
  $memo[uncovered]
end

def count_tilings(m, n)
  uncovered_set = (0...[m, n].max).flat_map { |i| (0...[m, n].min).to_a.map { |j| [i, j] } }
  tilings_recursive(Set.new(uncovered_set))
end

w = gets.to_i
h = gets.to_i

puts count_tilings(w, h)