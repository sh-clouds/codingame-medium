STDOUT.sync = true # DO NOT REMOVE

Options = [['J', 600, 0], ['H', 1200, 1], ['C', 2100, 5]]

L = gets.to_i
Water = gets.to_i
R = Options.length - 1

loop do
    N = gets.to_i
    F = Array.new(N) { gets.split.map(&:to_i) }
    while Options[R][1] > Water
        R -= 1
    end
    code, cost, thresh = Options[R]
    move = nil
    while move.nil?
        (0...(L - R)).each do |x|
            (0...(L - R)).each do |y|
                cnt = F.count { |a, b| (0 <= a - x && a - x <= R) && (0 <= b - y && b - y <= R) }
                if cnt > thresh
                    thresh, move = cnt, [x, y]
                end
            end
        end
        if move.nil?
            R -= 1
            code, cost, thresh = Options[R]
        end
    end
    puts "#{code} #{move[0]} #{move[1]}"
    Water -= cost
end
