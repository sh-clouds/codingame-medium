$height = 0
$width = 0
$grid = Array.new(30) { Array.new(129, '') }

def is_stable(i, j)
  if $grid[j][i] == '/'
    return (i != $width - 1 && $grid[j][i + 1] == '\\') && (j == $height - 1 || $grid[j + 1][i] == '\\')
  elsif $grid[j][i] == '\\'
    return (i != 0 && $grid[j][i - 1] == '/') && (j == $height - 1 || $grid[j + 1][i] == '/')
  end
  true
end

$height = gets.to_i
$width = $height * 2
$height.times do |i|
  $grid[i] = gets.chomp.split('')
end

$height.times do |i|
  (0...$width).each do |j|
    if !is_stable(j, i)
      puts "UNSTABLE"
      exit(0)
    end
  end
end

puts "STABLE"