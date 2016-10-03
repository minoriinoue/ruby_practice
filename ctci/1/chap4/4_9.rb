load('./queue.rb')

def init(sum, tree, result)
    original_sum = sum
    find_pass(original_sum, sum, result, tree, [])
end

def find_pass(original_sum, sum, result, tree_node, path)
    return if tree_node == nil
    # Case when we use the current tree node.
    path << tree_node.value
    next_sum = sum - tree_node.value
    if next_sum == 0
        result << path
    elsif next_sum > 0
        find_pass(original_sum, sum - tree_node.value, result, tree_node.left, path.dup)
        find_pass(original_sum, sum - tree_node.value, result, tree_node.right, path.dup)
    end
    # Case wheen we do not use the current tree node
    find_pass(original_sum, original_sum, result, tree_node.left, [])
    find_pass(original_sum, original_sum, result, tree_node.right, [])
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
# This might not be a good algorithm since we need 2^n checks.
# We could improve this algorithm by setting starting poin at each node and
# check if we can make a path from there. Each iteration taks logn on average,
# so it will take O(nlogn) time complexity.
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

bt = make_binary_tree([1,2,3,4,5,6,7,8,9,10])
result = []
init(8, bt, result)
result.each do |pass|
    print pass, "\n"
end
