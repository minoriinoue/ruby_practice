load './pqueue.rb'

def solve(n, l)
    pq = PQueueSmaller.new
    l.each do |e|
        pq.push(e)
    end
    return rec(n, pq)
end

def rec(n, pq)
    return 0 if n == 1
    first_min_e = pq.pop
    second_min_e = pq.pop
    new_e = first_min_e + second_min_e
    pq.push(new_e)
    return new_e + rec(n-1, pq)
end

n = 3
l = [8, 5, 8]

print "n: #{n}, l = #{l}, min cost: #{solve(n, l)}\n"
