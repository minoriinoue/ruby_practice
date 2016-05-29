class Node
    def initialization(value)
        @value = value
    end

    def append_to_tail(next_value)
        @next = Node.new(next_value)
    end
end

def make_list(length)
    header = Node.new(rand(1..10))
    tmp = header
    for i in 1..length-1
        
end
