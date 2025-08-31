m = gets.chomp
f = [8.08, 1.67, 3.18, 3.99, 12.56, 2.17, 1.80, 5.27, 7.24, 0.14, 0.63, 4.04, 2.60, 7.38, 7.47, 1.91, 0.09, 6.42, 6.59, 9.15, 2.79, 1.00, 1.89, 0.21, 1.65, 0.07]

STDERR.puts m

l = m.upcase
nb_letters = l.count("A-Z").to_f
fm = ("A".."Z").map{ |x| l.count(x) / nb_letters * 100 }

decal = 26.times.min_by{ |i|
    26.times.map{ |j| (f[j] - fm[j-i]) ** 2 }.sum
}

puts m.chars.map{|c|
    if c =~ /[a-z]/
        ((c.ord - 97 + decal) % 26 + 97).chr
    elsif c =~ /[A-Z]/
        ((c.ord - 65 + decal) % 26 + 65).chr
    else
        c
    end
}.join