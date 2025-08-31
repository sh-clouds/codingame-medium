class Stage
    attr_reader :w, :h, :stage
    
    def initialize(w, h)
        @w = w
        @h = h
        @stage = h.times.map{['.'] * w}
    end

    def initialize_copy(other)
        @w, @h = other.w, other.h
        s = other.stage.dup
        @stage = @h.times.map{|y| s[y].dup}
    end

    def set(x, y, v='*')
        if x < 0 or x >= @w or y < 0 or y >= @h
            puts "OUT OF BOUNDS"
        end
        @stage[y][x] = v
    end

    def get(x, y)
        @stage[y][x]
    end

    def check_rect(x, y, w, h)
        return false if x < 0 or x + w > @w or y < 0 or y + h > @h
        (x...x + w).each do |xp|
            (y...y + h).each do |yp|
                return false if get(xp, yp) != '.'
            end
        end
        true
    end

    def set_rect(x, y, w, h, v='*')
        (x...x + w).each do |xp|
            (y...y + h).each do |yp|
                set(xp, yp, v)
            end
        end
    end

    def to_s()
        @stage.map{|row| row.join}.join("\n")
    end
end

def get_states(stage, x, y, size)
    out = []
    v = stage.get(x, y)
    stage.set(x, y, '.')
    (1..size).select{|x| size % x == 0}.each do |d|
        w = d
        h = size / d
        (0...w).each do |xp|
            (0...h).each do |yp|
                rect = [x - xp, y - yp, w, h]
                out << rect if stage.check_rect(*rect)
            end
        end
    end
    stage.set(x, y, v)
    return out
end

def check_states(stage, numpos, out, result)
    if numpos.size == 0
        result << out
        return
    end
    _numpos = numpos.sort_by{|n| get_states(stage, *n).size}
    n = _numpos.shift
    states = get_states(stage, *n)
    states.each do |s|
        _stage = stage.dup
        _stage.set_rect(*s)
        check_states(_stage, _numpos, out + [s], result)
    end
end

w, h = gets.split.map(&:to_i)
stage = Stage.new(w, h)

numpos = []
(0...h).each do |y|
    gets.split.map(&:to_i).each.with_index do |v,x|
        if v != 0
            numpos << [x, y, v]
            stage.set(x, y)
        end
    end
end

result = []
check_states(stage, numpos, [], result)
m = ('A'..'Z').to_a + ('a'..'z').to_a
res = result.map do |r| 
    stage = Stage.new(w, h)
    r.sort_by{|s| [s[1], s[0]]}.each.with_index do |s,i|
        stage.set_rect(*s, m[i])
    end
    stage
end

p result.size
puts res.min_by{|s| s.stage.join}.to_s
