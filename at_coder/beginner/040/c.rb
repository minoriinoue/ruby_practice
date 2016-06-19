total = gets.chomp.to_i
a = gets.chomp.split(' ').map(&:to_i)


def rec(n, memo, a)
    if memo[n] >= 0
        return memo[n]
    end
    if n == 1
        memo[1] = 0
        return memo[1]
    elsif n == 2
        memo[2] = (a[1] - a[0]).abs
        return memo[2]
    else
        memo[n] = [rec(n-1, memo,a) + (a[n-1] - a[n-2]).abs, rec(n-2, memo, a) + (a[n-1] - a[n-3]).abs].min
        puts "memo[#{n}]: #{memo[n]}"
        return memo[n]
    end
end


memo = Array.new(total+1, -1)
print rec(total, memo, a), "\n"
