# Read number of nodes from standard input
number_of_nodes = gets.to_i
# Read the virus location from standard input
virus_location = gets.to_i
# Read number of links from standard input
number_of_links = gets.to_i

links = Hash.new { |hash, key| hash[key] = [] }

number_of_links.times do
  a, b = gets.split.map(&:to_i)
  links[a] << b
  links[b] << a
end

best_cut = 0
best_answer = 0

(0...number_of_nodes).each do |node_to_cut|
  next if node_to_cut == virus_location # We can't cut the infected node

  visited_nodes = { node_to_cut => true } # We simulate the fact that the node has been cut
  nodes_to_check = { virus_location => true }

  # Find how many nodes we can still reach from virus position
  until nodes_to_check.empty?
    new_nodes_to_check = {}

    nodes_to_check.each_key do |node|
      next if visited_nodes[node] # Skip if already visited
      visited_nodes[node] = true

      links[node].each do |neighbor|
        new_nodes_to_check[neighbor] = true
      end
    end

    nodes_to_check = new_nodes_to_check
  end
  
  if number_of_nodes - visited_nodes.size > best_cut
    best_cut = number_of_nodes - visited_nodes.size
    best_answer = node_to_cut
  end
end

puts best_answer