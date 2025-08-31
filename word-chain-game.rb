def game(last_letter = "", count = 0)
  first_letters = $words.map { |word| word[0] }
  $words.each do |word|
    if (count == 0 || word[0] == last_letter) && !first_letters.include?(word[-1])
      return count
    end
  end
  $words.each do |word|
    if count == 0 || word[0] == last_letter
      $words.delete(word)
      return game(word[-1], count + 1)
    end
  end
  return count - 1
end

$words = Array.new(gets.to_i) { gets.chomp }
puts ["Alice", "Bob"][game() % 2]


Input
Line 1: An integer N: the number of words in the word list.
Next N lines: A single string - a word in the word list.
Output
Print Alice or Bob, the winner of the game.
Constraints
1 ≤ N ≤ 16
The words in the word list are at most 12 letters long.
The words in the word list are all distinct.
Example
Input
4
dog
goat
cat
toad
Output
Alice

