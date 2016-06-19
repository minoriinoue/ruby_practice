n, x = gets.chomp.split(' ').map(&:to_i)

if x <= n / 2
    print x - 1, "\n"
else
    print n - x, "\n"
end
