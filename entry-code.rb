class EntryCode
  def initialize
    @digits = (0..(gets.to_i - 1)).map(&:to_s)
    @length = gets.to_i
  end

  def create_sequence(answer, sequence)
    return add_sequence(answer, sequence) if sequence.length == @length

    digits_range(sequence[0] == @digits.last).each { |digit| answer = create_sequence(answer, sequence + digit) }
    answer
  end

  private

  def digits_range(reversed)
    reversed ? @digits.reverse : @digits
  end

  def add_sequence(answer, code)
    answer.include?(code) ? answer : merge(answer, code)
  end

  def merge(answer, code)
    (code.size - 1).downto(1).each { |n| return answer + code[n..-1] if answer[-n, n] == code[0, n] }
    answer + code
  end
end

puts EntryCode.new.create_sequence('', '')