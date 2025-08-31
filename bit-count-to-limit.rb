n = gets.to_i

rL = 0
rP = 0
ret = 0

while n != 0 do
    if (n & 1) != 0
        ret += rL << (rL - 1)
        ret += rP + 1
        rP |= 1 << rL
    end
    n >>= 1
    rL += 1
end

puts ret