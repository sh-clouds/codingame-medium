n, e, start_id, goal_id = gets.split.map(&:to_i)
distances = gets.split.map(&:to_i)
edges = Hash.new { |hash, key| hash[key] = {} }
e.times do
    x, y, cost = gets.split.map(&:to_i)
    edges[x][y] = cost
    edges[y][x] = cost
end

class State
    attr_reader :cur_node, :prev_states, :cost_so_far, :cost_heuristic
    
    def initialize(cur_node, prev_states, cost_so_far, cost_heuristic)
        @cur_node = cur_node
        @prev_states = prev_states
        @cost_so_far = cost_so_far
        @cost_heuristic = cost_heuristic
    end

    def total_cost
        cost_so_far + cost_heuristic
    end

    def to_s
        "State(#{cur_node}, #{prev_states.map(&:cur_node).inspect}, #{cost_so_far}, #{cost_heuristic})"
    end
end

states = [State.new(start_id, [], 0, distances[start_id])]
nodes_visited = []

while state=states.shift
    next if nodes_visited.map(&:cur_node).include?(state.cur_node)
    nodes_visited << state
    
    break if state.cur_node == goal_id
    neighbors = edges[state.cur_node].keys
    neighbors.reject! { |id| nodes_visited.map(&:cur_node).include?(id) }

    states += neighbors.map do |neighbor_id|
        State.new(neighbor_id, 
                  state.prev_states + [state], 
                  state.cost_so_far + edges[state.cur_node][neighbor_id], 
                  distances[neighbor_id])
    end
    states.sort_by! { |s| [s.total_cost, s.cur_node] }
end

nodes_visited.each { |s| puts "#{s.cur_node} #{s.total_cost}" }