load('./linked_list.rb')

# Since we do not know the head of the list,
# We can just copy the value of the next node
# and pretend to have removed the node.
def delete_node(node)
    # Since the node given is supposed to be
    # the middle of the link, if the node.next
    # is nil it means the node given is the only
    # element in the list. Thus, don't need to
    # update anything.
    unless node.next == nil
        prev = nil
        while node.next != nil do
            node.value = node.next.value
            prev = node
            node = node.next
        end
        prev.next = nil
    end
end

list = generate_desire_list(['a', 'b', 'c', 'd', 'e'])
middle = list
for i in 0..1 do
    middle = middle.next
end

delete_node(middle)
show_values(list)
