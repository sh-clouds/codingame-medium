N = gets.to_i
puts N == 1 ? 1 : 2 * (N - (1 << (Math.log2(N - 1).to_i)))