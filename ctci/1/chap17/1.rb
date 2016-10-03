# Write a function to swap a number in place
# (that is, without temporary variables).

def swap_num_in_place(a, b)
    a += b # a = sum of (a, b)
    b = a - b # b = sum of (a, b) - original b = original a
    a = a - b # a = sum of (a, b) - calculated b (original a) = original b
    return [a, b]
end

print "swap 5, 2: #{swap_num_in_place(5,2)}\n"
print "swap -1, 5: #{swap_num_in_place(-1, 5)}\n"
