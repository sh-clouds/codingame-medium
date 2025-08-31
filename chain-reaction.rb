start_time = Time.now

height = gets.to_i
width = gets.to_i
inputs = Array.new(height * 3) { gets }

# We treat each button as a value [0-3]
buttons = []
(1...height * 3).step(3) do |y|
  (2...width * 5).step(5) do |x|
    if inputs[y - 1][x] != " "
      buttons << (inputs[y][x - 1] != " " ? 0 : 1)
    else
      buttons << (inputs[y][x + 1] != " " ? 2 : 3)
    end
  end
end

def solve(buttons, index, width, height)
  direction = 1
  rotations = 0
  to_rotate = { index => 1 }

  until to_rotate.empty?
    new_to_rotate = {}
    updated_buttons = buttons.dup

    to_rotate.each_key do |index|
      rotations += 1 # Increase rotation count

      updated_buttons[index] = (buttons[index] + direction + 4) % 4 # Rotate the button

      y = index / width
      x = index % width

      # Get the adjacent buttons that could be triggered
      check_left = check_top = check_right = check_bottom = 0

      case updated_buttons[index]
      when 0
        check_left = check_top = 1
      when 1
        check_right = check_top = 1
      when 2
        check_right = check_bottom = 1
      when 3
        check_left = check_bottom = 1
      end

      new_to_rotate[index - 1] = 1 if check_left == 1 && x > 0 && (buttons[index - 1] == 1 || buttons[index - 1] == 2)
      new_to_rotate[index + 1] = 1 if check_right == 1 && x < width - 1 && (buttons[index + 1] == 0 || buttons[index + 1] == 3)
      new_to_rotate[index - width] = 1 if check_top == 1 && y > 0 && (buttons[index - width] == 2 || buttons[index - width] == 3)
      new_to_rotate[index + width] = 1 if check_bottom == 1 && y < height - 1 && (buttons[index + width] == 0 || buttons[index + width] == 1)
    end

    to_rotate = new_to_rotate # The new buttons to rotate
    buttons = updated_buttons # We update all the buttons for the next turn
    direction *= -1 # Alternate anticlockwise & anti-anticlockwise
  end

  rotations
end

answer = [0, 0]

buttons.each_with_index do |button, index|
  rotations = solve(buttons, index, width, height)

  if rotations > answer[1]
    answer = [index, rotations]
  end
end

puts "#{answer[0] / width} #{answer[0] % width}"
puts answer[1]

error_log_time = Time.now - start_time