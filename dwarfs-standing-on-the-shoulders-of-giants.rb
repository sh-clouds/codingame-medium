class Node
  # Helper function to hold id and children of node.
  #
  # Methods:
  # initialize(id) - Initialise a node with given id.
  # add_child(id) - Adds id to children array.
  # get_id - Return id of node.
  # get_children - Returns array of children.
  
  def initialize(id)
    @id = id
    @children = []
  end

  def add_child(id)
    @children << id
  end

  def get_id
    @id
  end

  def get_children
    @children
  end
end

# Form graph using node class.
nodes = {}
n = gets.to_i
n.times do
  x, y = gets.split.map(&:to_i)

  nodes[x] ||= Node.new(x)
  nodes[y] ||= Node.new(y)

  nodes[x].add_child(y)
end

# DFS to find longest path - Using cache to speed up searching (0<N<10000 so may be required)
cache = {}
def search(node, nodes, cache)
  # Check in cache to speed up searching.
  return cache[node] if cache.key?(node)

  # Get children.
  children = nodes[node].get_children

  # If 'leaf' node - End of path so return 1.
  return 1 if children.empty?

  # Initialise length.
  length = 0

  # Recursive DFS to find max length of path that reaches a 'leaf'.
  children.each do |child|
    res = search(child, nodes, cache)
    length = [length, res + 1].max if res
  end

  # Cache and return.
  cache[node] = length
  length
end

# Output the number of people involved in the longest succession of influences
vals = []
nodes.each_key do |i|
  vals << search(i, nodes, cache)
end
puts vals.max
