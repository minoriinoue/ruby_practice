total = gets.chomp.to_i
a = gets.chomp.split(' ').map(&:to_i)

memo = Array.new(total+1, -1)
memo[1] = 0
memo[2] = (a[1] - a[0]).abs
(3..total).each do |e|
    memo[e] = [memo[e-1] + (a[e-1] - a[e-2]).abs, memo[e-2] + (a[e-1] - a[e-3]).abs].min 
end
puts memo[total]
