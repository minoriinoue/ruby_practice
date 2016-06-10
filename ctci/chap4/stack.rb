# This is an implementation for stack data structure
# achieved by linked-list.

class StackNode
    attr_accessor :value, :next
    
    def initialize(value)
        @value = value
        @next = nil
    end
end

class Stack
    attr_accessor :top
    def initialize
        @top = nil
    end

    def pop
        if @top != nil
            # Since a user should not access to
            # the next node to top, return only
            # data instead of node with next variable.
            item = @top.value
            @top = @top.next
            return item
        end
        return nil
    end

    def push(value)
        new_top = StackNode.new(value)
        new_top.next = @top
        @top = new_top
    end

    def is_empty
        if @top == nil
            return true
        else
            return false
        end
    end
end
