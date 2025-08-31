#****************************************#
#*                                      *#
#* CodinGame.com Solutions by pathosDev *#
#*                                      *#
#* Puzzle: Guessing n Cheating          *#
#* Difficulty: Easy                     *#
#* Date solved: 05.03.2019              *#
#*                                      *#
#****************************************#

rounds = gets.to_i

start_range, end_range = 1, 100

rounds.times do |i|
    # Read conversations.
    guess = gets.chomp.split()
    
    bob_guess = guess[0].to_i
    alice_response = "#{guess[1]} #{guess[2]}"
    
    # Adjust range.
    if alice_response == 'too low'
        start_range = [start_range, bob_guess + 1].max
    elsif alice_response == 'too high'
        end_range = [end_range, bob_guess - 1].min
    end

    # Check if alice cheated.
    if end_range < start_range || (alice_response == 'right on' && !(start_range <= bob_guess && bob_guess <= end_range))
        puts "Alice cheated in round #{i + 1}"
        exit
    end
end

# Alice didn't cheat.
puts 'No evidence of cheating'