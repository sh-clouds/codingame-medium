N = gets.to_i
dominoes = []

N.times do
  A, B = gets.split.map(&:to_i)
  dominoes << [A, B]
end

def solve(left, right, dominoes)
  return true if dominoes.empty? # We have used all the domino, there's a full sequence

  dominoes.each_with_index do |(a, b), i|
    dominoes.delete_at(i) # Remove the domino from the list

    # We add this domino at the left by using A
    return true if a == left && solve(b, right, dominoes)

    # We add this domino at the left by using B
    return true if b == left && solve(a, right, dominoes)

    # We add this domino at the right by using A
    return true if a == right && solve(left, b, dominoes)

    # We add this domino at the right by using B
    return true if b == right && solve(left, a, dominoes)

    dominoes.insert(i, [a, b]) # The domino was not used
  end

  false
end

left, right = dominoes.pop # We are searching for a full sequence, we can start with any dominoes
puts solve(left, right, dominoes) ? "true" : "false"

