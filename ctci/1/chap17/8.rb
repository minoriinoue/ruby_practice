def find_continuous_max(arr)
    largest_sum = 0
    con_nums = []
    for i in 0..arr.length-1 do
        start_index = i
        sum = 0
        tmp_arr = []
        for j in start_index..arr.length-1 do
            sum+= arr[j]
            break if sum <= 0
            tmp_arr << arr[j]
            if sum > largest_sum
                largest_sum = sum
                con_nums = tmp_arr
            end
        end
    end
    return [largest_sum, con_nums]
end

input = [2, -8, 3, -2, 4, -10]
result = find_continuous_max(input)
puts "max: #{result[0]}, arr: #{result[1]}"
input2 = [2, 3, -8, -1, 2, 4, -2, 3]
result2 = find_continuous_max(input2)
puts "max: #{result2[0]}, arr: #{result2[1]}"
