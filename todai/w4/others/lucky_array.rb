require './digit-sum.rb'

def lucky_array(n)
    result = [false]
    for i in 1..(n-1) do
        result[i] = (i % 7 == 0) || (digit_sum(i) % 7 == 0)
    end
    return result
end
