def if_binary_search_tree(root)
    if root.left == nil && root.right == nil
        return true
    elsif root.left == nil
        return (root.right.value > root.value) && if_binary_search_tree(root.right)
    elsif root.right == nil
        return (root.left.value <= root.value) && if_binary_search_tree(root.left)
    else
        return (root.right.value > root.value) && (root.left.value <= root.value) && if_binary_search_tree(root.right) && if_binary_search_tree(root.left)
    end
end

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

binary_search_tree = make_binary_tree([1,2,3,4,5,6,7,8,9,10])
binary_tree = make_binary_tree([1,2,3,4,5,6,7,8,9,1])
puts "binary_search_tree? #{if_binary_search_tree(binary_search_tree)}"
puts "binary_search_tree? #{if_binary_search_tree(binary_tree)}"
