require 'set'

def set_y_x(y, x)
  "#{y}-#{x}"
end

def get_y_x(yx)
  y, x = yx.split("-").map(&:to_i)
  return y, x
end

def check(y, x, n, out_list, abc_list, abc_dict, cages_dict, wert_dict)
  9.times do |i|
    return false if out_list[y][i] == n
    return false if out_list[i][x] == n
  end
  a = (y / 3) * 3
  b = (x / 3) * 3
  3.times do |i|
    3.times do |j|
      return false if out_list[a + i][b + j] == n
    end
  end
  abc = abc_list[y][x]
  wert = cages_dict[abc]
  abc_l = abc_dict[abc]
  summe = 0
  anz_null = 0
  abc_l.each do |yx|
    summe += out_list[yx[0]][yx[1]]
  end
  return false if summe + n > wert

  true
end

def zero(out_list, abc_list, abc_dict, cages_dict, wert_dict)
  9.times do |i|
    9.times do |j|
      return [i, j] if out_list[i][j] == 0
    end
  end
  nil
end

def solve(out_list, abc_list, abc_dict, cages_dict, wert_dict, ausg_list)
  z = zero(out_list, abc_list, abc_dict, cages_dict, wert_dict)
  # print("solve")
  return true if z.nil?
  y, x = z
  abc = abc_list[y][x]

  wert_list = wert_dict[abc]
  wert_list.each do |w_l|
    okay = true
    abc_l = abc_dict[abc]
    w_l.each_with_index do |w, i|
      ab = abc_l[i]
      if out_list[ab[0]][ab[1]] == 0
        rueck = check(ab[0], ab[1], w, out_list, abc_list, abc_dict, cages_dict, wert_dict)
        unless rueck
          okay = false
          break
        end
      else
        unless out_list[ab[0]][ab[1]] == w
          okay = false
          break
        end
      end
    end
    if okay
      w_l.each_with_index do |w, i|
        ab = abc_l[i]
        out_list[ab[0]][ab[1]] = w
      end
      return true if solve(out_list, abc_list, abc_dict, cages_dict, wert_dict, ausg_list)
      w_l.each_with_index do |_, i|
        ab = abc_l[i]
        if ausg_list[ab[0]][ab[1]] == 0
          out_list[ab[0]][ab[1]] = 0
        end
      end
    end
  end

  false
end

zahl_list = []
abc_list = []

9.times do
  grid_line, grid_cages = gets.chomp.split
  zahl_list << grid_line
  abc_list << grid_cages
end
cages = gets.chomp

start_zeit = Time.now
cages_dict = {}
abc_dict = {}
wert_dict = {}
cages.split(" ").each do |cage|
  abc, wert = cage.split("=")
  cages_dict[abc] = wert.to_i
  abc_dict[abc] = []
end
out_list = Array.new(9) { Array.new(9, 0) }
(0...9).each do |y|
  (0...9).each do |x|
    if zahl_list[y][x] == "."
      out_list[y][x] = 0
    else
      out_list[y][x] = zahl_list[y][x].to_i
    end
    abc = abc_list[y][x]
    abc_dict[abc] << [y, x]
  end
end

abc_dict.each do |abc, abc_l|
  if abc_l.length == 1
    ab = abc_l[0]
    out_list[ab[0]][ab[1]] = cages_dict[abc]
  end
  if cages_dict[abc] == abc_l.length
    abc_l.each do |ab|
      out_list[ab[0]][ab[1]] = 1
    end
  end
  if cages_dict[abc] == abc_l.length * 9
    abc_l.each do |ab|
      out_list[ab[0]][ab[1]] = 9
    end
  end

  wert = cages_dict[abc]
  w_list = []
  per_list = (1..9).to_a.permutation(abc_l.length).to_a
  per_list.each do |per|
    if per.sum == wert && per.max <= 9
      w_list << per
    end
  end
  wert_dict[abc] = w_list.dup

  # print("#{abc}  #{w_list.length} ", file: STDERR)
end

solve(out_list, abc_list, abc_dict, cages_dict, wert_dict, Marshal.load(Marshal.dump(out_list)))

(0...9).each do |y|
  (0...9).each do |x|
    print out_list[y][x]
  end
  puts ""
end