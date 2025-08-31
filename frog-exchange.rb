a = gets.chomp
a_reverse = ""

for i in 0...a.length
    a_reverse += a[a.length - 1 - i]
end

sex_which_starts_left = a[0]
frogs_sex = ["f", "f", "f", "f", "m", "m", "m", "m"]
left_side = ["f", "m", "f", "m", "f", "m", "f", "m"]
moves_of_s = [-4, 4, -2, 2, 4, -4, 2, -2]
ranges = [2, -1, 0, -1, -1, 2, -1, 0, 40, a.length - 3, 40, a.length - 1, a.length - 3, 40]
ranges.push(a.length - 1)
ranges.push(40)
index_of_s = a.length / 2
unoccupied_stones = [index_of_s]
index = []
sequence = [a]
start_index = 0

while a != a_reverse
    found = false 

    i = start_index
    while i < 8
        if sex_which_starts_left == left_side[i] && index_of_s > ranges[i]
            if index_of_s < ranges[i + 8]
                if a[index_of_s + moves_of_s[i]] == frogs_sex[i] && moves_of_s[i] < 0
                    next_a = a[0...index_of_s + moves_of_s[i]] + "s"
                    next_a += a[index_of_s + moves_of_s[i] + 1...index_of_s] + frogs_sex[i]
                    next_a += a[index_of_s + 1..-1]
                    a = next_a
                    found = true
                elsif a[index_of_s + moves_of_s[i]] == frogs_sex[i]
                    next_a = a[0...index_of_s] + frogs_sex[i]
                    next_a += a[index_of_s + 1...index_of_s + moves_of_s[i]] + "s"
                    next_a += a[index_of_s + moves_of_s[i] + 1..-1]
                    a = next_a
                    found = true
                end
            end
            if found
                sequence.push(a)
                index_of_s += moves_of_s[i]
                index.push(i)
                unoccupied_stones.push(index_of_s)
                start_index = 0
                break
            end
        end
        i += 1
    end
    
    unless found
        sequence.pop()
        a = sequence[-1]
        start_index = index[-1] + 1
        index.pop()
        unoccupied_stones.pop()
        index_of_s = unoccupied_stones[-1]
    end
end

for i in 0...sequence.length
    puts sequence[i]
end