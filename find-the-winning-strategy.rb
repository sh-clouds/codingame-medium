STDOUT.sync = true # DO NOT REMOVE

# I have to end my turn with NimSum != 0
number_of_rows = gets.to_i  # Number of rows
number_of_columns = gets.to_i  # Number of columns
nim_sum = 0
positions = []
nim_sum_positions = []

# game loop
while nim_sum > -1
    positions.clear
    nim_sum_positions.clear
    nim_sum = 0

    for i in 0...number_of_rows
        inputs = gets.split(' ')
        position_of_first_player_token = inputs[0].to_i  # Position of the first player's token
        position_of_second_player_token = inputs[1].to_i  # Position of the second player's token
        nim_sum ^= (position_of_second_player_token - 1 - position_of_first_player_token)
        positions << (position_of_second_player_token - 1 - position_of_first_player_token)
        nim_sum_positions << position_of_first_player_token
    end

    if nim_sum != 0
        for i in 0...number_of_rows
            if (positions[i] ^ nim_sum) < positions[i]
                row = i
                move = nim_sum_positions[i] + positions[i] - (positions[i] ^ nim_sum)
                puts "#{row} #{move}"
                break
            end
        end
    end
end