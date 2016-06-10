# This is an implementation for stack data structure
# achieved by linked-list.

class StackNode
    def initialize(value)
        @value = value
        @next = nil
    end
end

class Stack
    def initialize
        @top = nil
    end

    def pop
        if @top != nil
            # Since a user should not access to
            # the next node to top, return only
            # data instead of node with next variable.
            item = @top.data
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
end
