def output(links, index)
  output = index.to_s
  
  # This node has some connection
  if links[index].count > 0
    links[index].sort.each do |node_id, filler|
      links2 = links.dup
      links2[node_id].delete(index)

      output += " " + output(links2, node_id)
    end
  end

  "(" + output + ")"
end

prufer_code = gets.chomp.split(" ")

links = {}
# The number of nodes is the number of value in the prufer code + 2
# Initially all the nodes have a degree of 1
nodes = Array.new(prufer_code.size + 2, 1).each_with_index.to_h { |count, index| [index + 1, count] }

prufer_code.each do |node_id|
  nodes[node_id.to_i] += 1 # For each number in the Prufer code, increment its degree by 1
end

prufer_code.each do |node_id1|
  # Find the node with a count 1 with the smallest ID
  node_id2 = nodes.key(1)

  # Connect the current number in prufer code with the node we have just selected
  links[node_id1.to_i] ||= {}
  links[node_id1.to_i][node_id2] = 1
  links[node_id2] ||= {}
  links[node_id2][node_id1.to_i] = 1

  nodes.delete(node_id2)
  nodes[node_id1.to_i] -= 1 # Decrement the node we have just connected
end

# We have two nodes left, they are linked
n1 = nodes.keys.first
n2 = nodes.keys.last

links[n1] ||= {}
links[n1][n2] = 1
links[n2] ||= {}
links[n2][n1] = 1

R = gets.to_i

puts output(links, R)