# This is an implementation of queue by linked_list.
class QueueNode
    attr_accessor :value, :next
    def initialize(value)
        @value = value
        @next = nil
    end
end

class Queue
    attr_accessor :first, :last
    def initialize
        @first = nil
        @last = nil
    end

    def enque(value)
        if @first == nil
            @first = QueueNode.new(value)
            @last = @first
        else
            @last.next = QueueNode.new(value)
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

    def elements_to_array
        current = @first
        result = []
        while current != nil do
            result << current.value
            current = current.next
        end
        return result
    end
end
