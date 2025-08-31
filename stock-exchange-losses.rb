maximum_loss = 0
stock_prices = []
number_of_prices = gets.to_i
gets.split.each do |price|
  stock_prices << price.to_i
end

(0...(number_of_prices - 1)).each do |i|
  ((i + 1)...number_of_prices).each do |j|
    if stock_prices[i] < stock_prices[j]
      i = j
      break
    elsif maximum_loss < stock_prices[i] - stock_prices[j]
      maximum_loss = stock_prices[i] - stock_prices[j]
    end
  end
end

if maximum_loss != 0
  puts "-" + maximum_loss.to_s
else
  puts "0"
end
