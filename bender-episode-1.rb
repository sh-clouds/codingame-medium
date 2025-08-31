class Point
  attr_accessor :x, :y
  def initialize(x, y)
      self.x = x
      self.y = y
  end
end 

def indexOfObjectByValues(array, targetObject)
  0.upto(array.length-1) do |i|
      currentObject = array[i]
      if currentObject.x == targetObject.x && currentObject.y == targetObject.y           
          return i
      end    
  end
  return -1
end

class Blunder
  attr_accessor :x, :y, :map, :tp, :dirClock, :dir, :modeCasseur, :reverse, :dep, :visited
  def initialize(x, y, map, tp)
      map[y][x] = " "
      self.dirClock = ["S", "E", "N", "W"]
      self.dir = "S"
      self.x = x
      self.y = y
      self.map = map
      self.modeCasseur = false
      self.reverse = false
      self.dep = []
      self.tp = tp
      self.visited = {}
      self.simulate()
  end
        
  def simulate() 
    if self.checkLoop()
      self.dep = ["LOOP"]
      return
    end
      
    self.visited[self.getUniqueKey()] = true
    x, y = self.deplacement(self.x, self.y, self.dir) 
    nextDir = self.dir
    nextCase = self.map[y][x]
      
    if ["S", "E", "N", "W", " ", "I", "B"].include?(nextCase) 
      self.x = x
      self.y = y
    end
   
    if ["S", "E", "N", "W"].include?(nextCase)        
        nextDir = nextCase
        
    elsif ["#", "X"].include?(nextCase)
        if (nextCase == "X" && self.modeCasseur) 
            map[y][x] = " "
            self.x = x
            self.y = y
            self.visited = {}
        else
            i = self.reverse ? 3 : 0
            iEnd = self.reverse ? 0 : 3
            iInc = self.reverse ? -1 : 1
            
            while (i != iEnd) do
              _x, _y = self.deplacement(self.x, self.y, self.dirClock[i])
              c = self.map[_y][_x]
              if !(["#", "X"].include?(c)) 
                  self.dir = self.dirClock[i]
                  self.simulate()
                  return
              end
              i += iInc  
            end
            
            if (self.map[self.y][self.x] == "$") 
              self.dep.push(self.dir)
              return
            end
        end            
            
    elsif (nextCase == "I") 
        self.reverse = !self.reverse
        
    elsif (nextCase == "B")        
        self.modeCasseur = !self.modeCasseur       
            
    elsif (nextCase == "T") 
        index = indexOfObjectByValues(self.tp, Point.new(x,y))        
        if index == 0 
          self.x = self.tp[1].x
          self.y = self.tp[1].y
        else 
          self.x = self.tp[0].x
          self.y = self.tp[0].y
        end
    
    elsif (nextCase == "$") 
      self.dep.push(self.dir)
      return
    end    
      
    self.dep.push(self.dir)
    self.dir = nextDir   
    self.simulate()  
  end #simulate()     
    
  def deplacement(x, y, dir)
    case dir
    when "S"
        y += 1
    when "E"
        x += 1
    when "N"
        y -= 1
    when "W"
        x -= 1
    end
    return x, y 
  end
          
  def checkLoop()
    key = self.getUniqueKey() 
    return self.visited[key]
  end 
    
  def getUniqueKey() 
    return self.x.to_s + ":" + self.y.to_s + self.reverse.to_s + ":" + self.modeCasseur.to_s + ":" + self.dir.to_s
  end    
    
end


L, C= gets.split.map { |x| x.to_i }
map, tp = [],[]

# test1
#s =   ["#####",
#       "#@  #",
#       "#   #",
#       "#  $#",
#       "#####"];

start = Point.new(-1,-1)

0.upto(L-1) do |i|
    #row = s[i]
    row = gets.chomp
    map.push(row.split(""));
    
    0.upto(C-1) do |j| 
        if row[j] == "@"            
          start.x = j
          start.y = i
        end 
            
        if row[j] == "T"
          tp.push(Point.new(j,i))
        end    
    end
end
    
#0.upto(L-1) do |i|
#    print map[i].join("")
#    print "\n"
#end    
   
blunder = Blunder.new(start.x, start.y, map, tp)
#print blunder.inspect.to_s

0.upto(blunder.dep.length-1) do |i|
  case blunder.dep[i]
  when "S"
      puts "SOUTH"
  when "N"
      puts "NORTH"
  when "E"
      puts "EAST"
  when "W"
      puts "WEST"
  else
      puts "LOOP"
  end  
end