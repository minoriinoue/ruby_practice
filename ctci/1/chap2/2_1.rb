load('./linked_list.rb')

# O(n)
def remove_dup(list)
    value_counter = {}
    head = list
    tmp = head
    while tmp != nil
        value_counter[tmp.value] = 1
        break if tmp.next == nil
        tmp_next = tmp.next
        while value_counter.key?(tmp_next.value) do # dup found
            tmp_next = tmp_next.next
        end
        # tmp_next is a node with not dup value
        tmp.next = tmp_next
        tmp = tmp.next
    end
    return head
end

def remove_dup_improved(list)
    value_counter = {}
    prev = nil
    current = list
    while current != nil do
        if value_counter.key?(current.value)
            prev.next = current.next
            # Do not update prev value.
            current = prev.next
        else
            value_counter[current.value] = 1
            prev = current
            current = current.next
        end
    end
    return list
end

# When we cannot use hash table: O(1) space but O(n^2) time
def remove_dup_no_hash_table(list)
    current = list
    while current != nil do
        prev = current
        runner = current.next
        while runner != nil do
            if current.value == runner.value
                prev.next = runner.next
                # Do not update prev
            else
                prev = runner
            end
            runner = runner.next
        end
        current = current.next
    end
    return list
end

list = generate_desire_list([3,1,2,1,4,5,1,2,6])
list1 = generate_desire_list([3,1,2,1,4,5,1,2,6])
list2 = generate_desire_list([3,1,2,1,4,5,1,2,6])
list3 = generate_desire_list([3,1,2,1,4,5,1,2,6])
show_values(list)
show_values(remove_dup(list1))
show_values(remove_dup_improved(list2))
show_values(remove_dup_no_hash_table(list3))
