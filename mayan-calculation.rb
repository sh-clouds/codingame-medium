SYSTEM_SS = 20

class CalculateMaya
  attr_accessor :numerals, :num_1line, :num_2line, :operation

  def initialize
    l, h = gets.split.map(&:to_i)
    @numerals = Hash.new { |hash, key| hash[key] = [] }
    
    h.times do
      numeral = gets.chomp
      (0...numeral.length).step(l) do |j|
        @numerals[j / l] << numeral[j, l]
      end
    end

    s1 = gets.to_i
    @num_1line = Hash.new { |hash, key| hash[key] = [] }
    s1.times do |i|
      @num_1line[(s1 - i - 1) / h] << gets.chomp
    end

    s2 = gets.to_i
    @num_2line = Hash.new { |hash, key| hash[key] = [] }
    s2.times do |i|
      @num_2line[(s2 - i - 1) / h] << gets.chomp
    end

    @operation = gets.chomp
  end

  def calculate
    num1 = 0
    num2 = 0

    @num_1line.each do |key, value|
      num1 += get_numeral(value) * (20 ** key)
    end

    @num_2line.each do |key, value|
      num2 += get_numeral(value) * (20 ** key)
    end

    result = _make_operation(num1, num2).to_i
    _out(result)
  end

  def _make_operation(num1, num2)
    case @operation
    when "+"
      num1 + num2
    when "*"
      num1 * num2
    when "-"
      num1 - num2
    when "/"
      (num1.to_f / num2).ceil
    end
  end

  def get_numeral(value0)
    @numerals.each do |key, value|
      return key if value == value0
    end
    raise 'HiThere'
  end

  def get_ASCII(key0)
    @numerals.each do |key, ascii|
      return ascii.dup if key == key0
    end
    raise 'HiThere'
  end

  def _out(result)
    temp_array = []
    result_20 = []
    if result > 0
      while result > 0
        num = result % 20
        result_20 << num
        result = (result / 20).floor
        temp = get_ASCII(num)
        temp_array = temp + temp_array
      end
    else
      temp_array = get_ASCII(0)
    end

    temp_array.each_with_index do |item, i|
      puts item
    end
  end
end

calc = CalculateMaya.new
calc.calculate
