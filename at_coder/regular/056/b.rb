n, m, s = gets.chomp.split(' ').map(&:to_i)
roads = {}
roads.default = []
(1..m).each do
    u,v = gets.chomp.split(' ').map(&:to_i)
    roads[u] += [v]
    roads[v] += [u]
    puts "roads: #{roads}"
end
puts "roads: #{roads}"
(1..s).each do |e|
    current = [s]
    i = 0
    while i < 10 do
    #while !current.empty? do
        node = current.pop
        puts "node: #{node}"
        if roads[node] == nil #already used
        else
            puts "here"
            if node == e
                roads[node] = nil
                puts node
                break
            else
                current += roads[node]
            end
        end
        puts "current: #{current}"
        i+= 1
    end
end
