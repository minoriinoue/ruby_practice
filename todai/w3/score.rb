def score(a)
    sum = 0
    a.each do |element|
        # (a) variable sum is the sum of the values from the first
        # element to the last element with index at i-1. 
        sum += element
        # (b) variable sum is the sum of the values from the first
        # element to to the current element with index at i.
    end
    sum = sum - (a.max + a.min)
    return sum
end
