load('./linked_list.rb')

def partition_list(list_head, x)
    smaller_list_head = Node.new(nil)
    smaller_head = smaller_list_head
    greater_list_head = Node.new(nil)
    greater_head = greater_list_head
    while list_head != nil do
        if list_head.value >= x
            greater_list_head.next = list_head
            greater_list_head = greater_list_head.next
        else
            smaller_list_head.next = list_head
            smaller_list_head = smaller_list_head.next
        end
        list_head = list_head.next
    end
    greater_list_head.next = nil
    smaller_list_head.next = greater_head.next

    return smaller_head.next
end

list = generate_desire_list([3, 5, 1, 2, 1, 4, 2])
result = partition_list(list, 3)
show_values(result)
