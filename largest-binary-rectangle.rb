#concept:2D array
require 'set'

def max_histogram(row)
  result = []
  top_value, max_area, area, i = 0, 0, 0, 0
  while i < row.length
    if result.empty? || row[result.last] <= row[i]
      result.push(i)
      i += 1
    else
      top_value = row[result.pop]
      area = top_value * i
      if !result.empty?
        area = top_value * (i - result.last - 1)
      end
      max_area = [area, max_area].max
    end
  end
  while !result.empty?
    top_value = row[result.pop]
    area = top_value * i
    if !result.empty?
      area = top_value * (i - result.last - 1)
    end
    max_area = [area, max_area].max
  end
  max_area
end

def max_rectangle(array)
  result = max_histogram(array[0])
  (1...array.length).each do |i|
    (0...array[i].length).each do |j|
      if array[i][j] != 0
        array[i][j] += array[i - 1][j]
      end
    end
    result = [result, max_histogram(array[i])].max
  end
  result
end

width, height = gets.chomp.split.map(&:to_i)
array = Array.new(height) { Array.new(width, 0) }
(0...height).each do |i|
  gets.chomp.split.each_with_index do |value, j|
    array[i][j] = value.to_i
  end
end

puts max_rectangle(array)