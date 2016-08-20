load './fifo_q.rb'
class Vertex
    attr_accessor :edge, :color
    def initialize(color = nil)
        @edge = []
        @color = color
    end
end

class Graph
    attr_accessor :vertexes
    def initialize(values = [])
        @vertexes = {}
        values.each do |v|
            @vertexes[v] = Vertex.new
        end
    end

    def generate_edge(from, to)
        @vertexes[from].edge << @vertexes[to]
    end
end

g = Graph.new([0, 1, 2])
g.generate_edge(0, 1)
g.generate_edge(1, 0)
g.generate_edge(0, 2)
g.generate_edge(2, 0)
g.generate_edge(1, 2)
g.generate_edge(2, 1)

g2 = Graph.new([0, 1, 2,3])
g2.generate_edge(0,1)
g2.generate_edge(1,0)
g2.generate_edge(0,3)
g2.generate_edge(3,0)
g2.generate_edge(1,2)
g2.generate_edge(2,1)
g2.generate_edge(2,3)
g2.generate_edge(3,2)
def if_bipartite(graph)
    graph.vertexes[0].color = 0
    q = Queue.new
    q.enque(graph.vertexes[0])
    while (!q.if_empty?)
        current = q.deque
        current.edge.each do |e|
            if e.color == nil
                e.color = to_opposite_color(current.color)
                q.enque(e)
            else
                return false if e.color == current.color
            end
        end
    end
    return true
end

def to_opposite_color(color)
    if color == 1
        return 0
    else
        return 1
    end
end

# TODO: Let all the vertexes try to be the first node to paint
# in case there is a separate graph.

print "false: #{if_bipartite(g)}\n"
print "true: #{if_bipartite(g2)}\n"
