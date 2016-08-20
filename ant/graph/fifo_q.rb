class Node
    attr_accessor :value, :next
    def initialize(x = nil)
        @value = x
        @next = nil
    end
end

class Queue
    # This is FIFO queue implemented by list.
    # Methods are:
    #  enque(value)
    #   - Add a value to the queue
    #  deque
    #   - Remove value from the queue and return the value
    def initialize
        @first_que = nil
        @last_que = nil
    end

    def enque(v)
        que = Node.new(v)
        if @first_que == nil
            @first_que = que
            @last_que = que
        else
            @last_que.next = que
            @last_que = que
        end
    end

    def deque
        if @first_que == nil
            return false
        else
            que = @first_que
            @first_que = @first_que.next
            if @first_que == nil # the queue became empty
                @last_que = nil
            end
            return que.value
        end
    end

    def if_empty?
        return true if @first_que == nil
        return false
    end
end

# test
#fifo = Queue.new
#fifo.enque(1)
#fifo.enque(2)
#fifo.enque(3)
#print "1: #{fifo.deque}\n"
#print "2: #{fifo.deque}\n"
#print "3: #{fifo.deque}\n"
#print "false: #{fifo.deque}\n"
