# Get inputs.
register = gets.split.map(&:to_i).sort.reverse
goal_amount = gets.to_i

cache = {}
def min_coins(remaining_amount, cache, register)
    # Base cases
    return [] if remaining_amount == 0
    return nil if remaining_amount < 0

    # Return minimum if possible.
    return cache[remaining_amount] if cache.key?(remaining_amount)

    # Recursively search all combinations.
    coins = nil
    register.each do |coin|
        result = min_coins(remaining_amount - coin, cache, register)
        if result && (coins.nil? || result.length + 1 < coins.length)
            coins = result + [coin]
        end
    end

    # Set cache.
    cache[remaining_amount] = coins
    return coins
end

# Print the result
result = min_coins(goal_amount, cache, register)
if result.nil?
    puts "IMPOSSIBLE"
elsif result.empty?
    puts 0
else
    puts result.reverse.join(' ')
end
