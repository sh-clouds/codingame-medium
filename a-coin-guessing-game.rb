require 'set'

def is_odd(number)
  number.odd?
end

even_list = []
coin_list = {}
input_list = []
result = ""

n, t = gets.split.map(&:to_i)
t.times do
  input_list << gets.split.map(&:to_i)
end

(1..n * 2).step(2) do |i|
  even_list << i + 1
end

(1..n * 2).step(2) do |i|
  coin_list[i] = even_list.dup
end

input_list.each do |i_list|
  odd_list = []
  even_list = []
  i_list.each do |number|
    if is_odd(number)
      odd_list << number
    else
      even_list << number
    end
  end
  odd_list.each do |odd_number|
    c_list = coin_list[odd_number]
    even_list.each do |even_number|
      c_list.delete(even_number) if c_list.include?(even_number)
    end
  end
end

loop do
  break if coin_list.values.all? { |g_list| g_list.size <= 1 }

  change_occurred = false
  coin_list.each do |c, g_list|
    if g_list.size == 1
      value = g_list[0]
      coin_list.each do |c1, g_list1|
        if g_list1.size > 1 && g_list1.include?(value)
          g_list1.delete(value)
          change_occurred = true
        end
      end
    end
  end
  break unless change_occurred
end

sorted_keys = coin_list.keys.sort
sorted_keys.each do |key|
  value = coin_list[key]
  result += "#{value[0]} "
end
puts result.strip