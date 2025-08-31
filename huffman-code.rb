#concept: Greedy algorithms / Compression / Trees
class Node
  def initialize(frequency)
    @frequency = frequency
    @children = []
  end

  attr_reader :frequency, :children
end

def dfs(node, code)
  total_size = 0
  node.children.each_with_index do |child, index|
    total_size += dfs(child, code + ["1", "0"][index % 2 == 0 ? 0 : 1])
  end
  return code.length * node.frequency if node.children.empty?
  total_size
end

n = gets.to_i
tree = [] #building the relation tree
gets.split.each do |i|
  weight = i.to_i
  tree << Node.new(weight)
end

if tree.length == 1
  puts tree[0].frequency
else
  while tree.length != 1
    tree.sort_by!(&:frequency)
    node1 = tree.shift
    node2 = tree.shift
    node = Node.new(node1.frequency + node2.frequency)
    node.children.concat([node1, node2])
    tree << node
  end
  puts dfs(tree[0], "")
end