MOD = 10**9 + 7

s_2 = [1, 0, 1]
while s_2.length <= 1_000_000
    s_2 << (s_2[-2] + s_2[-3]) % MOD
end

s_3 = [1, 1, 1, 2, 3, 4, 8, 13, 19, 35]
while s_3.length <= 1_000_000
    s_3 << (s_3[-1] + 3 * s_3[-3] - 2 * s_3[-4] - s_3[-6] + s_3[-7] + s_3[-9]) % MOD
end

t = gets.to_i
t.times do
    k, n = gets.split.map(&:to_i)
    if k == 1
        puts n % 3 == 0 ? 1 : 0
    elsif k == 2
        puts s_2[n]
    else
        puts s_3[n]
    end
end