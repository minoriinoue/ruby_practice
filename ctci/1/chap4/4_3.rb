class TreeNode
    attr_accessor :value, :right, :left
    def initialize(value)
        @value = value
        @right = nil
        @left = nil
    end
end

# This code could improve by passing the same array, start and end index.
# By not copying the array everytime by array[start..half] we can save space complexity.
def make_binary_tree(sorted_array)
    if sorted_array.length == 0
        return nil
    elsif sorted_array.length == 1
        return TreeNode.new(sorted_array[0])
    end
    divide_index = sorted_array.length / 2
    tree_node = TreeNode.new(sorted_array[divide_index])
    tree_node.left = make_binary_tree(sorted_array[0..divide_index-1])
    tree_node.right = make_binary_tree(sorted_array[divide_index+1..sorted_array.length-1])
    return tree_node
end

def binary_tree_to_arr(tree)
    return nil if tree == nil
    return [binary_tree_to_arr(tree.left), tree.value, binary_tree_to_arr(tree.right)]
end

print binary_tree_to_arr(make_binary_tree([1,2,3,4,5,6,7,8,9,10])), "\n"
print binary_tree_to_arr(make_binary_tree([1,2,3,4,5,6,7,8,8,10])), "\n"
