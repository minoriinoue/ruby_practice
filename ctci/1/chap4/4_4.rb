load('./stack.rb')
load('./queue.rb')

def generate_linked_list_at_each_depth(bst)
    stack = Stack.new
    stack.push(bst) # Push the top node of the tree.
    result = [] # This will contain linked_lists at each depth.
    head = LinkedListNode.new(nil)
    current_ll_node = head
    tmp = []
    while !stack.is_empty do
        tmp_1 = stack.pop
        current_ll_node.next = LinkedListNode.new(tmp_1.value) # Store the value of the bst node.
        tmp << tmp_1
        if stack.is_empty # Finished inspecting all the node at the depth.
            result << head.next # head is an empty node.
            head = LinkedListNode.new(nil)
            current_ll_node = head
            tmp.each do |same_level_node|
                stack.push(same_level_node.right) if same_level_node.right != nil
                stack.push(same_level_node.left) if same_level_node.left != nil
            end
            tmp = []
        else
            current_ll_node = current_ll_node.next
        end
    end
    return result
end

class LinkedListNode
    attr_accessor :value, :next
    def initialize(value)
        @value = value
        @next = nil
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

def generate_queue_array(queue)
    result_arr = []
    while queue != nil do
        result_arr << queue.value
        queue = queue.next
    end
    return result_arr
end

tree = make_binary_tree([1,2,3,4,5,6,7,8,9,10])
print "binary_tree: ", binary_tree_to_arr(tree), "\n"
arr_of_ll = generate_linked_list_at_each_depth(tree)
arr_of_ll.each do |ll|
    print generate_queue_array(ll), "\n"
end
