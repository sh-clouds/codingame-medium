def run_build(left_side, right_side)
  if right_side.length == 1
    if eval("#{left_side}#{right_side}") == K
      puts "#{left_side}#{right_side}"
    end
  else
    ['', '+', '-'].each do |instruction|
      run_build("#{left_side}#{right_side[0]}#{instruction}", right_side[1..-1])
    end
  end
end

N = gets.strip
K = gets.to_i
run_build("", N)