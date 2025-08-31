n = gets.to_i
n.times do
  line = gets.chomp

  line_in_list = line.split(" ")
  values = []
  works = true

  line_in_list.each do |word|
    begin
      values << Integer(word)
    rescue
      works = false
      break
    end
  end

  if works
    dolls_sizes = []
    inside = []
    solid_dolls = 0

    values.each_with_index do |value, j|
      if value == 0
        works = false
      elsif value < 0
        if j > 0 && dolls_sizes.empty?
          works = false
        end
        unless dolls_sizes.empty?
          inside[-1] += value
          works = false if dolls_sizes[-1] >= inside[-1]
        end
        dolls_sizes << value
        inside << 0
      elsif dolls_sizes.empty?
        works = false
      elsif dolls_sizes[-1] * -1 != value
        works = false
      else
        solid_dolls += 1 if value == values[j - 1] * -1
        dolls_sizes.pop
        inside.pop
      end
      break unless works
    end

    works = false if dolls_sizes.length > 0
    puts solid_dolls if works
  end

  puts "-1" unless works
end