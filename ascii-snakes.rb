DIR = { 'U' => [0, -1], 'D' => [0, 1], 'L' => [-1, 0], 'R' => [1, 0] }
REV = { 'U' => 'D', 'D' => 'U', 'L' => 'R', 'R' => 'L', '_' => '_' }

def generate_block(direction)
  if direction == '_D'
    result = '+-+| |'
  elsif direction == '_R'
    result = '+--+--'
  elsif ['UD', 'DU'].include?(direction)
    result = '| || |'
  elsif ['UL', 'LU'].include?(direction)
    result = '+ |--+'
  elsif ['UR', 'RU'].include?(direction)
    result = '| ++--'
  elsif ['DL', 'LD'].include?(direction)
    result = '--++ |'
  elsif ['DR', 'RD'].include?(direction)
    result = '+--| +'
  elsif ['LR', 'RL'].include?(direction)
    result = '------'
  elsif direction == 'U_'
    result = '| |+-+'
  elsif direction == 'D_'
    result = '+-+| |'
  elsif direction == 'L_'
    result = '--+--+'
  elsif direction == 'R_'
    result = '+--+--'
  elsif direction == '  '
    result = '      '
  else
    raise ArgumentError, "unknown #{direction}"
  end
  result
end

input_message = gets.chomp.rstrip
message_length = input_message.length
board = Array.new(30) { Array.new(30, '  ') }
last_direction = '_'
ox = 0
oy = 0
mx = 0
my = 0

input_message.each_char.with_index do |char, index|
  board[oy][ox] = REV[last_direction] + char
  ox += DIR[char][0]
  oy += DIR[char][1]
  mx = [mx, ox + 1].max
  my = [my, oy + 1].max
  last_direction = char
end

board[oy][ox] = REV[last_direction] + '_'
canvas = Array.new(my * 2) { Array.new(mx * 3, '   ') }

(0...my).each do |y|
  (0...mx).each do |x|
    block_string = generate_block(board[y][x])
    (0...3).each do |r|
      canvas[y * 2][(x * 3) + r] = block_string[r]
    end
    (3...6).each do |r|
      canvas[(y * 2) + 1][(x * 3) + r - 3] = block_string[r]
    end
  end
end

canvas.each do |line|
  puts line.join.rstrip
end