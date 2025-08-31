# Get how many person we can add when we have someone at the start and the end with a given size
def solve(size)
  @history ||= {}

  return @history[size] if @history.key?(size)

  return 0 if size < 5 # Not enough space to add more

  middle = size >> 1

  @history[size] = 1 + solve(middle + 1) + solve(size - middle)
end

start_time = Time.now

n = gets.to_i

solution = [0, 0]

(0...(n >> 1)).each do |i|
  count = 1

  # We can add people on the left
  count += 1 + solve(i + 1) if i >= 2

  # We can add people on the right
  count += 1 + solve(n - i) if i < n - 2

  # Starting here results in a higher count
  if count > solution[0]
    solution = [count, i + 1]
  end
end

puts solution.join(" ")

error_log_time = Time.now - start_time