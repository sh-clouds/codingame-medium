for _ in 0...gets.to_i
    binary_input = gets.chomp
    integer_value = binary_input.to_i(2)
    if integer_value == 0
        puts '0'
    else
        integer_value -= 1
        length = 1
        while integer_value >= length * 2**(length - 1)
            integer_value -= length * 2**(length - 1)
            length += 1
        end
        quotient, remainder = integer_value.divmod(length)
        quotient += 2**(length - 1)
        puts "#{quotient.to_s(2)[remainder]}"
    end
end