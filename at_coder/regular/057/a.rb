a, b = gets.chomp.split.map(&:to_i)
#day = 1
#while (a < 2000000000000) do
#    a += (1+b*a)
#    day += 1
#end
#puts day - 1
if b == 0
    puts 2000000000000 - a
else
    puts (Math.log((2000000000000 + 1/b)/(a+ 1/b), 1+b)).to_i + 1
end
