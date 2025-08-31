number_of_steps = gets.chomp.to_i

steps = [ (1..number_of_steps).to_a ]

(1..number_of_steps).each do |current_step|
  list_of_steps = []

  (0...number_of_steps).each do |index|
    # We alternate from the end and the start of the array
    adjusted_index = index / 2
    if index % 2 == 0
      adjusted_index = number_of_steps - adjusted_index - 1
    end
    list_of_steps << steps[current_step - 1][adjusted_index]
  end

  steps << list_of_steps
end

if steps[number_of_steps] == steps[0]
  puts steps[1..-1].map { |step| step.join(",") }.join("\n")
else
  puts "IMPOSSIBLE"
end