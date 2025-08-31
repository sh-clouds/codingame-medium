def 
  r(m)
  m.map(&:chars).transpose.map &:join
end

s, c, *m = *$<
m = r(m.map &:chomp).sort.reverse
puts c.to_i.odd?? m:r(m)
gravity-tumbler
