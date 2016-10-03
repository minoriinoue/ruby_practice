# This is the implementation for tree structure.

class Node
    def initialize(value)
        @value = value
        @parent = nil
        @left = nil
        @right = nil
    end
end

class Tree
    def initialize
        @root = nil
    end

    def add_value(value)
        if @root == nil
            @root = Node.new(value)
        else
            prev_node = nil
            current_node = @root
            while current_node != nil do
                prev_node = current_node
                if current_node.value > value
                    current_node = current_node.left
                else
                    current_node = current_node.right
                end
            end
            if prev_node.value > value
                prev_node.left = Node.new(value)
                prev_node.left.parent = prev_node
            else
                prev_node.right = Node.new(value)
                prev_node.right.parent = prev_node
            end
        end
    end
end
