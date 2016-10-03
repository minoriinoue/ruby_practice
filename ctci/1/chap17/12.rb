def find_pair_of_a_sum(arr, want_value)
    mid = want_value / 2
    value_counter = Array.new(mid+1, 0)
    arr.each do |e|
        if e > mid
            value_counter[want_value - e] += 1
        else
            value_counter[e] += 1
        end
    end
    result = []
    value_counter.each_with_index do |v, i|
        pair_num = v / 2
        while pair_num > 0 do
            result << [i, want_value - i]
            pair_num -= 1
        end
    end
    return result
end

input = [3, 2, 4, 5, 2, 1]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0, 3]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
