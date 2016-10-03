class Node
    attr_accessor :value, :next
    def initialize(value)
        @value = value
        @next = nil
    end
end

def generate_list(length)
    head = Node.new(rand(1..10))
    tmp = head
    for i in 1..length do
        tmp.next = Node.new(rand(1..10))
        tmp = tmp.next
    end
    return head
end

def generate_desire_list(value_arr)
    if value_arr.length == 0
        return false
    end
    head = Node.new(value_arr[0])
    tmp = head
    for i in 1..value_arr.length-1 do
        tmp.next = Node.new(value_arr[i])
        tmp = tmp.next
    end
    return head
end

def show_values(list)
    result = []
    while(list != nil) do
        result << list.value
        list = list.next
    end
    puts "-----------"
    print result, "\n"
    puts "-----------"
end


