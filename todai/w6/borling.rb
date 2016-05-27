def function(a)
    max = 0
    start_index = 0
    while index != (a.length -1)
        start_index = index
        index_looking_at = index
        sum = 0
        while index_looking_at != a.length - 1
            if a[index_looking_at] < 0
                start_index = index_looking_at + 1
                break
            else
                sum += a[index_looking_at]
            end
        end
        if max < sum
            max = sum
        end
    end
end
