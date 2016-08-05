a, b, k, l = gets.chomp.split(' ').map(&:to_i)
set = k / l
rest = k % l
if rest == 0
    puts set * b
else
    puts [(set + 1) * b, rest * a + set * b].min
end
