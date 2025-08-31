mapa = []
w = gets.to_i
h = gets.to_i
h.times do
  row = gets.chomp
  mapa << row.chars
end

def dar_adya(x, y)
  ret = []
  ret << [x, y]
  ret << [x + 1, y]
  ret << [x, y + 1]
  ret << [x + 1, y + 1]
  return ret
end

def dar_columnas(mapa)
  mapa2 = []
  (0...mapa[0].length).each do |k|
    mapa2 << mapa.map { |j| j[k] }
  end
  return mapa2    
end

def contar_llenas(mapa)
  s = 0
  mapa.each do |fila|
    s += 1 if !fila.include?(".")
  end
  mapa2 = dar_columnas(mapa)
  mapa2.each do |fila|
    s += 1 if !fila.include?(".")
  end
  return s
end

posibles = []
(0...h).each do |k|
  (0...w).each do |j|
    if mapa[k][j] == "."
      adya = []
      begin
        if mapa[k + 1][j] == "." && mapa[k][j + 1] == "." && mapa[k + 1][j + 1] == "."
          posibles << dar_adya(k, j)
        end
      rescue
      end
    end
  end
end

def copiar_mapa(mapa)
  ret = []
  mapa.each do |fila|
    ret << fila.dup
  end
  return ret
end

mayor = contar_llenas(mapa)
posibles.each do |pos|
  mapa2 = copiar_mapa(mapa)
  pos.each do |cor|
    mapa2[cor[0]][cor[1]] = "#"
    temp = contar_llenas(mapa2)
    mayor = temp if temp > mayor
  end
end

puts mayor