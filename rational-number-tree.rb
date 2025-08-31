# Generate the LR path to a fraction
def get_path(input)
  m, n = input.split("/").map(&:to_i)
  path = ""

  start = [0, 1]
  end_fraction = [1, 0]
  
  loop do
    mediant = [start[0] + end_fraction[0], start[1] + end_fraction[1]]

    break if mediant == [m, n] # We have reach our fraction

    # Current mediant is bigger than the fraction, we need to move Left
    if mediant[0].to_f / mediant[1] > m.to_f / n
      path += "L"
      end_fraction = mediant
    # Current mediant is lower, we need to move Right 
    else
      path += "R"
      start = mediant
    end
  end

  path
end

# Generate the fraction from the LR path
def get_fraction(path)
  start = [0, 1]
  end_fraction = [1, 0]
  mediant = [1, 1]

  path.each_char do |char|
    # With a Left the new upper bound is the mediant
    if char == 'L'
      end_fraction = mediant
    # With a Right the new lower bound is the mediant
    else
      start = mediant
    end

    # Update the mediant
    mediant = [start[0] + end_fraction[0], start[1] + end_fraction[1]]
  end

  "#{mediant[0]}/#{mediant[1]}"
end

N = gets.to_i
N.times do
  line = gets.strip

  if line.include?("/")
    puts get_path(line)
  else
    puts get_fraction(line)
  end
end