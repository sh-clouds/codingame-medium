Alien = Struct.new(:type, :hp, :armor, :damage, :turns)

aliens = gets.to_i.times.map do |i|
    type, hp, armor, damage = gets.split(" ")
    strength = [1, (type == "FIGHTER" ? 20 : 10) - armor.to_i].max
    turns = (hp.to_f / strength).ceil
    Alien.new(type, hp.to_i, armor.to_i, damage.to_i, turns)
end

shield = 5000

aliens.sort_by!{|a| a.turns / a.damage.to_f}
#p aliens

while aliens.length > 0 do
    damage = aliens.map{|a| a.damage}.inject(&:+) * aliens[0].turns
    shield -= damage
    #p "shield #{shield}, damage #{damage}, turns #{aliens[0].turns}"

    aliens.delete_at(0)
end

puts shield < 0 ? "FLEE" : shield