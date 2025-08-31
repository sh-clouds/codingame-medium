class DLXCell
  attr_accessor :prev_x, :next_x, :prev_y, :next_y, :rh, :size

  def initialize(x, y, v)
    @prev_x = self
    @next_x = self
    @prev_y = self
    @next_y = self
    @rh = nil
    # @point = [x, y]
    # @value = v
    @size = 0
  end

  def remove_x
    @prev_x.next_x = @next_x
    @next_x.prev_x = @prev_x
  end

  def remove_y
    @prev_y.next_y = @next_y
    @next_y.prev_y = @prev_y
  end

  def restore_x
    @prev_x.next_x = self
    @next_x.prev_x = self
  end

  def restore_y
    @prev_y.next_y = self
    @next_y.prev_y = self
  end

  def attach_horiz(other)
    n = @next_x
    other.next_x = n
    n.prev_x = other
    @next_x = other
    other.prev_x = self
  end

  def attach_vert(other)
    n = @next_y
    other.next_y = n
    n.prev_y = other
    @next_y = other
    other.prev_y = self
  end

  def remove_column
    remove_x
    node = @next_y
    while node != self
      node.remove_row
      node = node.next_y
    end
  end

  def restore_column
    node = @prev_y
    while node != self
      node.restore_row
      node = node.prev_y
    end
    restore_x
  end

  def remove_row
    node = @next_x
    while node != self
      node.rh.size -= 1
      node.remove_y
      node = node.next_x
    end
  end

  def restore_row
    node = @prev_x
    while node != self
      node.rh.size += 1
      node.restore_y
      node = node.prev_x
    end
  end

  def select
    node = self
    while true
      node.remove_y
      node.rh.remove_column
      node = node.next_x
      break if node == self
    end
  end

  def unselect
    node = @prev_x
    while node != self
      node.rh.restore_column
      node.restore_y
      node = node.prev_x
    end
    node.rh.restore_column
    node.restore_y
  end
end

n = gets.to_i
grid = {}
n.times do |y|
  gets.chomp.chars.each_with_index do |v, x|
    grid[[x, y]] = v.to_i
  end
end

matrix = []

(0...n).each do |x|
  (0...n).each do |y|
    (0...n).each do |v|
      cons1 = x + y * n  # every cell
      cons2 = x + v * n  # val in every col
      cons3 = y + v * n  # vali in every row
      matrix << [cons1, cons2, cons3, grid[[x, y]] == (v + 1), x, y, v + 1]
    end
  end
end

node_id = 0

root = DLXCell.new(-1, -1, -1)
headers = Array.new(3 * n * n) { DLXCell.new(-1, -1, -1) }
headers.each { |header| root.attach_horiz(header) }
to_remove = []
matrix.each do |(a, b, c, cons, x, y, gridv)|
  b += n * n
  c += 2 * n * n
  prevcell = nil
  [a, b, c].each_with_index do |v, i|
    nc = DLXCell.new(x, y, gridv)
    nc.rh = headers[v]
    headers[v].attach_vert(nc)
    nc.rh.size += 1
    if prevcell
      prevcell.attach_horiz(nc)
    else
      prevcell = nc
    end
  end
  to_remove << prevcell if cons
end

to_remove.each(&:select)

def solve(grid, root)
  best = root
  best_size = 10_000_000
  n = root.next_x
  while n != root
    if n.size < best_size
      best_size = n.size
      best = n
    end
    n = n.next_x
  end

  return 1 if best == root
  
  node = best.next_y
  ans = 0
  while node != best
    node.select
    ans += solve(grid, root)
    node.unselect
    node = node.next_y
  end
  ans
end

puts solve(grid, root)