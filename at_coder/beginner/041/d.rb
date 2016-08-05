n, m = gets.chomp.split.map(&:to_i)
# hash: usagi => 後ろにきていいusagis
usagi_ushiro = {}
dp = {}
(1..n).each do |num|
    usagi_ushiro[num] = Array(1..n)
    usagi_ushiro[num].delete(num) #自分は消す
end
(1..m).each do |num|
    x, y = gets.chomp.split.map(&:to_i)
    usagi_ushiro[y].delete(x)
end
puts "usagi_ushiro: #{usagi_ushiro}"
def rec(usagi, banme, prev, usagi_ushiro, max)
    puts "banme: #{banme}"
    if banme == max
        puts "OK!!!!!!!!!!!!!!!!!!!"
        return 1
    end
    puts "usagi: #{usagi}, prev: #{prev}"
    possible = usagi_ushiro[usagi] - prev
    prev.each do |p|
        possible = possible & usagi_ushiro[p]
    end
    puts "possible: #{possible}"
    if possible.empty?
        puts "EMPTY!!!!!!!!!!!!!!!!!!"
        return 0
    end
    sum = 0
    possible.each do |usa|
        sum += rec(usa, banme+1, prev + [usagi], usagi_ushiro, max)
    end
    return sum
end

sum = 0
(1..n).each do |usagi|
    prev = []
    sum += rec(usagi, 1, prev, usagi_ushiro, n)
end
puts sum
