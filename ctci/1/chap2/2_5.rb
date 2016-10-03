load('./linked_list.rb')

def sum_reverse(link1, link2)
    increment = 0
    prev_node = Node.new(nil)
    head = prev_node
    while link1 != nil && link2 != nil do
        if link1 == nil && link2 != nil
            tmp = link2.value + increment
            increment = tmp / 10
            prev_node.next = Node.new(tmp % 10)
            link2 = link2.next
        elsif link1 != nil && link2 == nil
            tmp = link1.value + increment
            increment = tmp / 10
            prev_node.next = Node.new(tmp % 10)
            link1 = link1.next
        else
            tmp = link1.value + link2.value + increment
            increment = tmp / 10
            prev_node.next = Node.new(tmp % 10)
            link1 = link1.next
            link2 = link2.next
        end
        prev_node = prev_node.next
    end
    if increment != 0
        prev_node.next = Node.new(increment)
    end
    return head.next
end

list1 = generate_desire_list([7,1,6])
list2 = generate_desire_list([5,9,2])
show_values(sum_reverse(list1, list2))
