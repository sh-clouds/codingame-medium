require 'set'

def hash_bst(nodes)
  if nodes.empty?
    return ""
  end
  root, *remaining_nodes = nodes
  greater_than_root = remaining_nodes.select { |n| n > root }
  less_than_root = remaining_nodes.select { |n| n < root }
  current_hash = (greater_than_root.empty? ? "0" : "1") + (less_than_root.empty? ? "0" : "1")
  return current_hash + hash_bst(greater_than_root) + hash_bst(less_than_root)
end

n, k = gets.split.map(&:to_i)
seen_hashes = Set.new
n.times do
  nodes = gets.split.map(&:to_i)
  seen_hashes.add(hash_bst(nodes))
end

puts seen_hashes.size