include Math
n = gets.chomp.to_i

max = sqrt(n).to_i

min_v = Float::INFINITY

(1..max).each do |e|
    a = n / e
    tmp = (n - e* a) + (a - e).abs
    if tmp < min_v
        min_v = tmp
    end
end

puts min_v


