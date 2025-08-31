class Graph
    # Initialisation of graph
    def initialize(vertices)
        # No. of vertices
        @vertices = vertices
        # adjacency list
        @adj = Hash.new { |hash, key| hash[key] = [] }
    end

    def add_edge(u, v)
        # add u to v's list
        @adj[u] << v
        # since the graph is undirected
        @adj[v] << u
    end

    # method return farthest node and its distance from node u
    def bfs(u)
        # marking all nodes as unvisited
        visited = Array.new(@vertices + 1, false)
        # mark all distance with -1
        distance = Array.new(@vertices + 1, -1)
        # distance of u from u will be 0
        distance[u] = 0
        # in-built library for queue which performs fast operations on both the ends
        queue = Queue.new
        queue.push(u)
        # mark node u as visited
        visited[u] = true

        until queue.empty?
            # pop the front of the queue (0th element)
            front = queue.pop
            # loop for all adjacent nodes of node front
            @adj[front].each do |i|
                unless visited[i]
                    # mark the ith node as visited
                    visited[i] = true
                    # make distance of i, one more than distance of front
                    distance[i] = distance[front] + 1
                    # Push node into the stack only if it is not visited already
                    queue.push(i)
                end
            end
        end

        max_distance = 0
        node_index = 0
        # get farthest node distance and its index
        (0...@vertices).each do |i|
            if distance[i] > max_distance
                max_distance = distance[i]
                node_index = i
            end
        end
        return node_index, max_distance
    end

    # method prints longest path of given tree
    def longest_path_length
        # first DFS to find one end point of longest path
        node, distance = bfs(0)
        # second DFS to find the actual longest path
        node_2, longest_distance = bfs(node)
        # print('Longest path is from', node, 'to', node_2, 'of length', longest_distance)
        return longest_distance
    end
end

n = gets.to_i
graph = Graph.new(n + 1)
n.times do
    a, b = gets.split.map(&:to_i)
    graph.add_edge(a, b)
    graph.add_edge(b, a)
end
# longest distance between nodes -> longest_distance
puts (graph.longest_path_length * 0.5).ceil
