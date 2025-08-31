RESULT1 = {
    'A+' => ['A+', 'A-', 'O+', 'O-'],
    'A-' => ['A-', 'O-'],
    'B+' => ['B+', 'B-', 'O+', 'O-'],
    'B-' => ['B-', 'O-'],
    'O+' => ['O+', 'O-'],
    'O-' => ['O-'],
    'AB+' => ['A+', 'A-', 'B+', 'B-'],
    'AB-' => ['A-', 'B-'],
}

RESULT2 = {
    'A+' => {'A+' => 'A+', 'A-' => 'A+', 'B+' => 'AB+', 'B-' => 'AB+', 'O+' => 'A+', 'O-' => 'A+'},
    'A-' => {'A+' => 'A+', 'A-' => 'A-', 'B+' => 'AB+', 'B-' => 'AB-', 'O+' => 'A+', 'O-' => 'A-'},
    'B+' => {'A+' => 'AB+', 'A-' => 'AB+', 'B+' => 'B+', 'B-' => 'B+', 'O+' => 'B+', 'O-' => 'B+'},
    'B-' => {'A+' => 'AB+', 'A-' => 'AB-', 'B+' => 'B+', 'B-' => 'B-', 'O+' => 'B+', 'O-' => 'B-'},
    'O+' => {'A+' => 'A+', 'A-' => 'A+', 'B+' => 'B+', 'B-' => 'B+', 'O+' => 'O+', 'O-' => 'O+'},
    'O-' => {'A+' => 'A+', 'A-' => 'A-', 'B+' => 'B+', 'B-' => 'B-', 'O+' => 'O+', 'O-' => 'O-'},
}

# We have both parents, generate all the possible children
def generate_child(parent1, parent2)
    possibilities = {}

    RESULT1[parent1].each do |rp1|
        RESULT1[parent2].each do |rp2|
            possibilities[RESULT2[rp1][rp2]] = true
        end
    end

    return possibilities.keys
end

# We have a parent and the child, generate all the possible second parent
def generate_parent(parent, child)
    possibilities = {}

    RESULT1[parent].each do |p1|
        RESULT1.each do |p2, list_|
            list_.each do |type_|
                if RESULT2[p1][type_] == child
                    possibilities[p2] = true
                    break
                end
            end
        end
    end

    return possibilities.keys
end

N = gets.to_i

N.times do
    parent1, parent2, child = gets.split

    if child == '?'
        list_ = generate_child(parent1, parent2)
        sorted_list = list_.sort
        puts sorted_list.join(" ")
    else
        list_ = generate_parent(parent1 != '?' ? parent1 : parent2, child)

        if list_.empty?
            puts "impossible"
        else
            sorted_list = list_.sort
            puts sorted_list.join(" ")
        end
    end
end
