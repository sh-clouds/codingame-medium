# frozen_string_literal: true

# Detect which particle just passed through the cloud chamber,
# if unknown, you may win the Nobel prize of physics!
def gamma(v)
  1.0 / Math.sqrt(1.0 - v * v)
end

def circle_from_3_points(z1, z2, z3)
  i = Complex(0, 1)
  w = (z3 - z1) / (z2 - z1)
  if w.imag == 0
    [-1, -1]

  else
    c = (z2 - z1) * (w - w.abs**2) / (2 * i * w.imag) + z1
    r = (z1 - c).abs
    [c, r]
  end
end
w = gets.to_i # width of ASCII-art picture (one meter per column)
h = gets.to_i # height of ASCII-art picture (one meter per line)
b = gets.to_f # strengh of magnetic field (tesla)
v = gets.to_f # speed of the particle (speed-of-light unit)
art = []
h.times do
  art << gets.chomp # lines of ASCII-art picture
end

# Write an answer using puts
# To debug: STDERR.puts "Debug messages..."

# "<symbol> <radius>" if charged particle
# "<symbol> inf" if neutral particle
# "I just won the Nobel prize in physics !" if unknown particle
particles = [[-1, 0.511, 'e-'],
             [1, 938.0, 'p+'], [0, 940.0, 'n0'], [2, 3727.0, 'alpha'], [1, 140.0, 'pi+']]

pos = []
art.each_with_index do |line, y|
  warn line
  line.chars.each_with_index do |c, x|
    pos << Complex(x.to_f, y.to_f) if c == ' '
  end
end
# Iterate to find the best circle

z0 = pos.sample
z1 = pos.sample
z1 = pos.sample while z1 == z0
z2 = pos.sample
z2 = pos.sample while z2 == z0 || z2 == z1

c, r = circle_from_3_points(z0, z1, z2)
if r < 0
  puts 'n0 inf'
else
  best = -1
  best_r = 0
  1000.times do
    d = pos.map { |z| [((z - c).abs - r).abs, z] }.sort { |a, b| b[0] <=> a[0] }
    if best == -1 || best > d[0][0]
      best = d[0][0]
      best_r = r
    end
    z0 = pos.sample
    z1 = pos.sample
    z1 = pos.sample while z1 == z0
    z2 = pos.sample
    z2 = pos.sample while z2 == z0 || z2 == z1

    c, r = circle_from_3_points(z0, z1, z2)
  end

  best = -1
  best_p = -1
  r = (best_r / 10.0 + 0.5).to_i * 10
  
  g = 1.0e6 * gamma(v) * v / (b * r * 299_792_458)
 
  particles.each_with_index do |p, i|
    gp = (p[0] / p[1]).abs
   
    if best == -1 || (gp - g).abs / gp < best
      best = (gp - g).abs / gp
      best_p = i
    end
  end
  if best < 0.5

    p = particles[best_p]
    puts "#{p[2]} #{(r / 10 + 0.5).to_i * 10}"
  else
    puts 'I just won the Nobel prize in physics !'
  end

end
