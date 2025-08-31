STDOUT.sync = true # DO NOT REMOVE
require 'set'

# n: the total number of nodes in the level, including the gateways
# l: the number of links
# e: the number of exit gateways
n, l, e = gets.split.map(&:to_i)
link_tree = Array.new(n) { [] }
gateways = []
l.times do
    # n1: N1 and N2 defines a link between these nodes
    node1, node2 = gets.split.map(&:to_i)
    link_tree[node1] << node2
    link_tree[node2] << node1
end
e.times do
    gateways << gets.to_i  # the index of a gateway node
end

# game loop
loop do
    agent_position = gets.to_i  # The index of the node on which the Skynet agent is positioned this turn
    queue = [agent_position]
    visited_nodes = Set.new
    action_output = ""
    until queue.empty? || action_output != ""
        current_node = queue.shift
        visited_nodes.add(current_node)
        link_tree[current_node].each do |next_node|
            if gateways.include?(next_node)
                link_tree[current_node].delete(next_node)
                action_output = "#{current_node} #{next_node}"
                break
            elsif !visited_nodes.include?(next_node) && !queue.include?(next_node)
                queue << next_node
            end
        end
    end
    puts action_output
end