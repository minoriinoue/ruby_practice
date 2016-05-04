# Did not come up with 'ordinary method'.
# So I just converted integer to string and sumed the each elemnt.
def digit_sum(n)
    str_num = n.to_s
    sum = 0
    for index in 0..str_num.length do
        # (a) Variable sum is the sum of the numbers up to n.to_s[index-1]
        sum += str_num[index].to_i
        # (b) Variable sum is the sum of the numbers up to n.to_s[index]
    end
    return sum
end
