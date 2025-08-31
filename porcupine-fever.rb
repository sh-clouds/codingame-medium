class Cage
  def initialize(sick, healthy, alive)
    @sick = sick
    @healthy = healthy
    @alive = alive
  end

  def count_alive
    @alive -= @sick
    @healthy -= @sick * 2
    @sick *= 2
    return 0 if @alive < 0
    @alive
  end
end

n = gets.to_i
y = gets.to_i
list_cage = []
n.times do
  inputs = gets.split(" ")
  s = inputs[0].to_i
  h = inputs[1].to_i
  a = inputs[2].to_i
  list_cage << Cage.new(s, h, a)
end

y.times do
  count = 0
  list_cage.each do |cage|
    count += cage.count_alive
  end
  puts count
  break if count == 0
end