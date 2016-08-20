class UnionFind
    def initialize
        # value to its node map
        @forest = {}
    end

    def make_set(x)
        tn = TreeNode.new(x)
        @forest[x] = tn
    end

    # unite the node with value x and y
    def union(x, y)
        print "-------union #{x}, #{y} ---------"
        link(find_set(x), find_set(y))
    end

    # link two trees
    def link(x_tn, y_tn)
        print "x_tn in link: #{x_tn} value: #{x_tn.value}\n"
        print "y_tn in link: #{y_tn} value: #{y_tn.value}\n"
        if x_tn.rank > y_tn.rank
            y_tn.parent = x_tn
        else
            x_tn.parent = y_tn
            if x_tn.rank == y_tn.rank
                y_tn.rank += 1
            end
        end
    end

    # find the respresentative node while re-connecting to
    # its root.
    def find_set(x)
        x_tn = @forest[x]
        return nil if x_tn == nil
        #print "x_tn in find_set: #{x_tn}\n"
        if x_tn.parent != x_tn
            x_tn.parent = find_set(x_tn.parent.value)
        end
        #print "x_tn.parent in find_set: #{x_tn.parent}\n"
        return x_tn.parent
    end

    # for debug
    def show_all_elements
        @forest.each do |k, v|
            while true
                print "#{v.value} "
                v = v.parent
                break if v == v.parent
            end
            print "#{v.value} \n"
        end
    end
end

class TreeNode
    attr_accessor :value, :parent, :rank
    def initialize(element)
        @value = element
        @parent = self
        @rank = 0
    end
end

# test
#uf = UnionFind.new([1,2,3,4,5, 6, 7])
#uf.union(1,2)
#uf.union(2,5)
#uf.union(6,4)
#uf.union(4,7)
#uf.union(2,4)
#uf.show_all_elements
