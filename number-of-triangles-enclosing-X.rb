class Point
  attr_accessor :x, :y, :name

  def initialize(info)
    @name, coord = info.split(" ")
    @x, @y = coord.split(";").map(&:to_f)
  end
end

def area(point1, point2, point3)
  return (point1.x * (point2.y - point3.y) + point2.x * (point3.y - point1.y) + point3.x * (point1.y - point2.y)).abs / 2.0
end

def is_inside?(point1, point2, point3, pointX)
  # Calculate area of triangle ABC
  area_total = area(point1, point2, point3)

  # Calculate area of triangle PBC
  area1 = area(pointX, point2, point3)

  # Calculate area of triangle PAC
  area2 = area(point1, pointX, point3)

  # Calculate area of triangle PAB
  area3 = area(point1, point2, pointX)

  # Check if sum of area1, area2 and area3 is same as area_total
  return (area_total.round(8) == (area1 + area2 + area3).round(8))
end

pointX_info = gets.chomp
pointX = Point.new(pointX_info)

N = gets.to_i

points = []
N.times do
  points << Point.new(gets.chomp)
end

count = 0

(0...N).each do |index1|
  (index1 + 1...N).each do |index2|
    (index2 + 1...N).each do |index3|
      count += 1 if is_inside?(points[index1], points[index2], points[index3], pointX)
    end
  end
end

puts count
