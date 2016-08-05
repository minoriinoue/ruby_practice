# This is the implementation of priority queue by heap in Ruby.
#
# 
# This file contains 2 classes:
#   1. PQueueLarger
#      - Larger elements are priotized.
#   2. PQueueSmaller
#      - Smaller elements are priotized.
#
# Each class includes the following methods:
#   1. top
#      - Obtain the top element in the priotized order.
#   2. pop
#      - Remove the top element
#   3. push(element)
#      - Add an element
#   4. if_empty?
#      - Check if the pqueue has any element

class PQueueLarger
    def initialize
        @pqueue = Array.new
    end

    def top
        return nil if @pqueue.empty?
        return @pqueue[0]
    end

    def pop
        return nil if @pqueue.empty?
        top_element = @pqueue[0]
        print "@pqueue[-1]: #{@pqueue[-1]}\n"
        @pqueue[0] = @pqueue[-1]
        @pqueue.delete_at(-1)
        print "@pqueue #{@pqueue}\n"
        sort_in_order unless @pqueue.empty?
        return top_element
    end
    
    def sort_in_order
        index = 1
        while (true)
            print "@pqueue #{@pqueue}\n"
            parent = @pqueue[index - 1]
            left = @pqueue[index * 2 - 1]
            right = @pqueue[index * 2]
            print "parent: #{parent}, left: #{left}, right: #{right}\n"
            break if left == nil && right == nil
            if left != nil && right != nil
                # Check which element in the 3 (parent, left, right) nodes
                # is the largest.
                if parent >= left && parent >= right
                    # Heap condition is met.
                    break
                elsif left > parent && left > right
                    @pqueue[index * 2 - 1] = parent
                    @pqueue[index - 1] = left
                    index = index * 2
                elsif right > parent && right > left
                    @pqueue[index * 2] = parent
                    @pqueue[index - 1] = right
                    index = index * 2 + 1
                end
            elsif left == nil
                if parent >= right
                    break
                else
                    @pqueue[index - 1] = right
                    @pqueue[index * 2] = parent
                    index = index * 2 + 1
                end
            else
                if parent >= left
                    break
                else
                    @pqueue[index - 1] = left
                    @pqueue[index * 2] = parent
                    index = index * 2 + 1
                end
            end
        end
    end

    def push(element)
        @pqueue << element
        index = @pqueue.length - 1
        while index != 0 do
            parent_index = (index - 1) / 2
            if @pqueue[index] > @pqueue[parent_index]
                tmp = @pqueue[index]
                @pqueue[index] = @pqueue[parent_index]
                @pqueue[parent_index] = tmp
                index = parent_index
            else
                break
            end
        end
    end

    def if_empty?
        return true if @pqueue.empty?
        return false
    end

    def show_array
        return @pqueue
    end
end

class PQueueSmaller
    def initialize
        @pqueue = Array.new
    end

    def top
        return nil if @pqueue.empty?
        return @pqueue[0]
    end

    def pop
        return nil if @pqueue.empty?
        top_element = @pqueue[0]
        @pqueue[0] = @pqueue[-1]
        @pqueue.delete_at(-1)
        sort_in_order unless @pqueue.empty?
        return top_element
    end
    
    def sort_in_order
        index = 1
        while (true)
            parent = @pqueue[index - 1]
            left = @pqueue[index * 2 - 1]
            right = @pqueue[index * 2]
            break if left == nil && right == nil
            if left != nil && right != nil
                # Check which element in the 3 (parent, left, right) nodes
                # is the largest.
                if parent <= left && parent <= right
                    # Heap condition is met.
                    break
                elsif left < parent && left < right
                    @pqueue[index * 2 - 1] = parent
                    @pqueue[index - 1] = left
                    index = index * 2
                elsif right < parent && right < left
                    @pqueue[index * 2] = parent
                    @pqueue[index - 1] = right
                    index = index * 2 + 1
                end
            elsif left == nil
                if parent <= right
                    break
                else
                    @pqueue[index - 1] = right
                    @pqueue[index * 2] = parent
                    index = index * 2 + 1
                end
            else
                if parent <= left
                    break
                else
                    @pqueue[index - 1] = left
                    @pqueue[index * 2] = parent
                    index = index * 2 + 1
                end
            end
        end
    end

    def push(element)
        @pqueue << element
        #print "@pqueue: #{@pqueue}\n"
        index = @pqueue.length - 1
        while index != 0 do
            parent_index = (index - 1) / 2
            #print "index: #{index}, parent_index: #{parent_index}\n"
            if @pqueue[index] < @pqueue[parent_index]
                tmp = @pqueue[index]
                @pqueue[index] = @pqueue[parent_index]
                @pqueue[parent_index] = tmp
                index = parent_index
            else
                break
            end
        end
    end

    def if_empty?
        return true if @pqueue.empty?
        return false
    end

    def show_array
        return @pqueue
    end
end

# For debugging PQueueLarger 
#pq = PQueueLarger.new
#arr = [8, 7, 5, 4, 2, 1]
#arr.each do |e|
#    pq.push(e)
#end
#print "Array: #{pq.show_array}\n"

#pq.push(9)
#print "Array: #{pq.show_array}\n"

#pq.pop
#print "Array: #{pq.show_array}\n"

#For debugging PQueueSmaller
#pq = PQueueSmaller.new
#arr = [1, 2, 4, 7, 8, 5]
#arr.each do |e|
#    pq.push(e)
#end
#print "Array: #{pq.show_array}\n"

#pq.push(3)
#print "Array: #{pq.show_array}\n"

#pq.pop
#print "Array: #{pq.show_array}\n"


