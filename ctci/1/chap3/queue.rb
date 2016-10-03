# This is an implementation of queue by linked_list.
class Node
    def initialize(value)
        @value = value
        @next = nil
    end
end

class Queue
    def initialize
        @first = nil
        @last = nil
    end

    def enque(value)
        if @first == nil
            @first = Node.new(value)
            @last = @first
        else
            @last.next = Node.new(value)
            @last = @last.next
        end
    end

    def deque
        if @first == nil
            return nil
        end
        item = @first.value
        @first = @first.next
        return item
    end
end
