require 'logger'

source_input = gets.strip
target_input = gets.strip

logger = Logger.new(STDERR)
logger.error("source: #{source_input}")
logger.error("target: #{target_input}")

$checked = {}

def solve(source_string, target_string)
  global_checked = $checked

  # Use saved value
  return global_checked[[source_string, target_string]] if global_checked.key?([source_string, target_string])

  # Both are the same, no switch needed
  if source_string == target_string
    global_checked[[source_string, target_string]] = 0
    return 0
  end

  size = source_string.length

  # Find the first difference
  (0...size).each do |index|
    if source_string[index] != target_string[index]
      # Just the last bulb, we can always directly switch it
      if index == size - 1
        global_checked[[source_string, target_string]] = 1
        return 1
      end

      # This is the state we need to be able to switch the first difference
      intermediate_state = "1" + "0" * [0, size - index - 2].max

      global_checked[[source_string, target_string]] = (
        1 + solve(source_string[index + 1..-1], intermediate_state) + solve(intermediate_state, target_string[index + 1..-1])
      )
      return global_checked[[source_string, target_string]]
    end
  end
end

result = solve(source_input, target_input)
puts result