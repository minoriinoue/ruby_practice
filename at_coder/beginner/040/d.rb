n, m = gets.chomp.split(' ').map(&:to_i)
roads = {}
(1..m).each do
    a,b,y = gets.chomp.split(' ').map(&:to_i)
    if roads.key?(a)
      if roads[a][b] == nil
        roads[a][b] = y
      elsif roads[a][b] < y
        roads[a][b] = y
      end
    else
        roads[a] = {b => y}
    end
    if roads.key?(b)
      if roads[b][a] == nil
        roads[b][a] = y
      elsif roads[b][a] < y
        roads[b][a] = y
      end
    else
        roads[b] = {a => y}
    end
end


def count_city(city, year, roads)
  count = 1
  visited = {}
  queue = Array.new
  queue << city
  visited[city] = true
  while !queue.empty? do
      cities = roads[queue.pop]
      unless cities == nil
        cities.each do |c, y|
            if visited.key?(c)
            else
                if y > year
                    count += 1
                    queue << c
                    visited[c] = true
                end
            end
        end
      end
  end
  return count
end
q = gets.chomp.to_i
memo_city_year = {}
(1..q).each do
    city, year = gets.chomp.split(' ').map(&:to_i)
    puts count_city(city, year, roads)
end
