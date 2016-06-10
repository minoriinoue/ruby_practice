# Check if the tree is balanced by checking if the node's children are
# balanced.

load('./class_tree.rb')
load('./make_binary_search_tree.rb')
def init(root)
    if if_balanced(root) < 0
        puts "This tree is not balanced."
    else
        puts "This tree is balanced."
    end
end

# If it is balanced, return the height of the tree.
# Otherwise, return -1.
# Since this code checks all the node, time complexity
# is O(N).
# TODO(minoriinoue): Figure out why this space complexity
# is O(logN).
def if_balanced(node)
    if node == nil
        return 0
    end
    right_node_h = if_balanced(right(node))
    left_node_h = if_balanced(left(node))
    if right_node_h >= 0 && left_node_h >= 0
        if (right_node_h - left_node_h).abs <= 1
            return [right_node_h, left_node_h].max + 1
        end
    end
    return -1
end

tree1 = make_binary_search_tree([3,2,4,1,5])
tree2 = make_binary_search_tree([3,2,4,1,5,0,6])
init(tree1)
init(tree2)
