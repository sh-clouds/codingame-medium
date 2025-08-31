number_of_piles = gets.chomp.to_i
piles = gets.chomp.split.map(&:to_i)
turn_number = 1
history = {}

# Search for the loop
while true
  piles.reject!(&:zero?) # Remove piles that are empty
  piles.sort!
  current_state = piles.join(" ") # The state of the piles

  # Stop if we reach a loop
  if history.key?(current_state)
    puts (turn_number - history[current_state]).to_s
    exit
  else
    history[current_state] = turn_number
  end

  piles.map! { |pile| pile - 1 } # Remove 1 from each pile
  piles << piles.size # New pile size is just the count of existing piles
  turn_number += 1
end
