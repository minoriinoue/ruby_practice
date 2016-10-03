load('./stack.rb')
class GraphNode
    def initialize(value)
        @value = value
        @adjacent = []
    end

    def add_adjacent(value)
        @adjacent << GraphNode.new(value)
    end
end

class Graph
    def initialize(value)
        @start = GraphNode.new(value)
    end

    def make_directed_graph_of_6(values)
        # start value is already given when making the tree.
        if values.length != 5
            print "Please provide 5 different numbers."
            return
        end
        graph_structure = [[1,0,0,0,1,1],[1,1,1,1,0,0],[1,1,1,1,0,1],[1,1,1,1,1,1],[1,1,1,1,1,0],[1,1,1,1,1,1]]
        graph = [@start]
        1..5.each do |i|
            graph << GraphNode.new(values[i])
        end
        graph.each_with_index do |graph_node, index|
            graph_structure[index].each_with_index do |if_adjacent, node_index|
                if if_adjacent == 0
                    graph_node.adjacent << graph[node_index]
                end
            end
        end
    end
end
