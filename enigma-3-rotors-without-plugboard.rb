class Rotor
  attr_accessor :wire, :revwire, :trig, :state, :turn

  def initialize(message, trigger = "")
    @wire = message.split.map { |x| x.split('-')[1].ord - 65 }
    @revwire = Array.new(26, 0)
    @wire.each_with_index { |i, n| @revwire[i] = n }
    @trig = trigger.empty? ? -1 : trigger.ord - 65
    @state = 0
    @turn = false
  end

  def set_state(char)
    @state = char.ord - 65
  end

  def increment_rotor
    @turn = true
  end

  def forward(char, val = false)
    prev = @turn
    if val || @turn
      @state = (@state + 1) % 26
      @turn = false
    end
    [((65 + (@wire[(char.ord - 65 + @state) % 26] - @state) % 26).chr), (@state == @trig && (prev || val))]
  end

  def backward(char)
    (65 + (@revwire[(char.ord - 65 + @state) % 26] - @state) % 26).chr
  end
end

rotor1 = Rotor.new(gets.chomp, gets.chomp)
rotor2 = Rotor.new(gets.chomp, gets.chomp)
rotor3 = Rotor.new(gets.chomp, gets.chomp)
reflector = Rotor.new(gets.chomp)

r1, r2, r3 = gets.chomp.split
rotor1.set_state(r1)
rotor2.set_state(r2)
rotor3.set_state(r3)

output = ""
gets.chomp.each_char do |char|
  message, turn1 = rotor1.forward(char, true)
  message, turn2 = rotor2.forward(message)
  rotor2.increment_rotor if turn1
  message, turn3 = rotor3.forward(message)
  rotor3.increment_rotor if turn2
  rotor2.increment_rotor if turn2

  message, _turn = reflector.forward(message)

  message = rotor3.backward(message)
  message = rotor2.backward(message)
  message = rotor1.backward(message)

  output += message
end

puts output