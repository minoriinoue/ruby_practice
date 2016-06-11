def find_successor(node)
    if node.right != nil
        return find_min(node.right)
    end
    y = node.parent
    while (y.left != node) && y != nil do
        node = y
        y = y.parent
    end
    return y
end

def find_min(node)
    while node.left != nil do
        node = node.left
    end
    return node
end

class TreeNode
    attr_accessor :value, :right, :left, :parent
    def initialize(value, parent)
        @value = value
        @right = nil
        @left = nil
        @parent = parent
    end
end

# This code could improve by passing the same array, start and end index.
# By not copying the array everytime by array[start..half] we can save space complexity.
def make_binary_tree(sorted_array, parent)
    if sorted_array.length == 0
        return nil
    elsif sorted_array.length == 1
        return TreeNode.new(sorted_array[0], parent)
    end
    divide_index = sorted_array.length / 2
    tree_node = TreeNode.new(sorted_array[divide_index], parent)
    tree_node.left = make_binary_tree(sorted_array[0..divide_index-1], tree_node)
    tree_node.right = make_binary_tree(sorted_array[divide_index+1..sorted_array.length-1], tree_node)
    return tree_node
end

def binary_tree_to_arr(tree)
    return nil if tree == nil
    return [binary_tree_to_arr(tree.left), tree.value, binary_tree_to_arr(tree.right)]
end

def find_node(tree, value)
    while tree != nil do
        if tree.value == value
            return tree
        elsif tree.value > value
            tree = tree.left
        else
            tree = tree.right
        end
    end
end

tree = make_binary_tree([1,2,3,4,5,6,7,8,9,10], nil)
node_with_value3 = find_node(tree, 3)
puts "successor of 3 is: #{find_successor(node_with_value3).value}"
node_with_value5 = find_node(tree, 5)
puts "successor of 5 is: #{find_successor(node_with_value5).value}"
