# 金子先生のチェック済み

class Node
    attr_reader :value, :left, :right
    def initialize(value, left, right)
        @value = value
        @left = left
        @right = right
    end
end

def make_node(num, left, right)
    Node.new(num, left, right)
end
def value(tree)
    tree.value
end
def left(tree)
    tree.left
end
def right(tree)
    tree.right
end
def make_leaf(value)
    Node.new(value, nil, nil)
end
