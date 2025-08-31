# Get the cycle-length of the Syracuse Conjecture
def syracuse_conjecture(memory, n)
    return memory[n] if memory.key?(n)

    if n.odd?
        memory[n] = 1 + syracuse_conjecture(memory, n * 3 + 1)
    else
        memory[n] = 1 + syracuse_conjecture(memory, n / 2)
    end
end

memory = {1 => 1}

N = gets.to_i
N.times do
    A, B = gets.split.map(&:to_i)

    longest_cycle_length = -Float::INFINITY
    index_with_longest_cycle = 0

    (A..B).each do |i|
        cycle_length = syracuse_conjecture(memory, i)
        if cycle_length > longest_cycle_length
            longest_cycle_length = cycle_length
            index_with_longest_cycle = i
        end
    end

    puts "#{index_with_longest_cycle} #{longest_cycle_length}"
end