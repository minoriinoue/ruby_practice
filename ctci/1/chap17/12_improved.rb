# Pass time is almost the same somehow for all the functions.
def find_pair_of_a_sum(arr, want_value)
    mid = want_value / 2
    value_counter = {}
    value_counter.default = 0
    arr.each do |e|
        if e > mid
            value_counter[want_value - e] += 1
        else
            value_counter[e] += 1
        end
    end
    result = []
    value_counter.each do |i, v|
        pair_num = v / 2
        while pair_num > 0 do
            result << [i, want_value - i]
            pair_num -= 1
        end
    end
    return result
end

old = Time.now
input = [3, 2, 4, 5, 2, 1]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0, 3]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
input = [-2, -1, 0, 3, 5, 6, 7, 9, 13, 14]
want_value = 12
puts "Pairs whose sum becomes #{want_value} are: #{find_pair_of_a_sum(input, want_value)}"
current = Time.now
puts "Pass time for the first function: #{current - old}"

# Problem of this algorithm: to delete elements.
def model_answer(arr, want_value)
    int_to_int = {}
    result = []
    arr.each do |e|
        if int_to_int.key?(want_value - e)
            result << [e, want_value - e]
        end
        int_to_int[e] = true
    end
    return result
end

old = Time.now
input = [3, 2, 4, 5, 2, 1]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{model_answer(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{model_answer(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0, 3]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{model_answer(input, want_value)}"
input = [-2, -1, 0, 3, 5, 6, 7, 9, 13, 14]
want_value = 12
puts "Pairs whose sum becomes #{want_value} are: #{model_answer(input, want_value)}"
current = Time.now
puts "Past time for model answer: #{current - old}"

def less_loop_find_pair_of_a_sum(arr, want_value)
    mid = want_value / 2
    value_counter = {}
    value_counter.default = 0
    result = []
    arr.each do |e|
        if e > mid
            key = want_value - e
        else
            key = e
        end
        value_counter[key] += 1
        if value_counter[key] == 2
            result << [key, want_value - key]
        end
    end
    return result
end

old = Time.now
input = [3, 2, 4, 5, 2, 1]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{less_loop_find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{less_loop_find_pair_of_a_sum(input, want_value)}"
input = [3, 2, 4, 5, 2, 1, 0, 3]
want_value = 5
puts "Pairs whose sum becomes #{want_value} are: #{less_loop_find_pair_of_a_sum(input, want_value)}"
input = [-2, -1, 0, 3, 5, 6, 7, 9, 13, 14]
want_value = 12
puts "Pairs whose sum becomes #{want_value} are: #{less_loop_find_pair_of_a_sum(input, want_value)}"
current = Time.now
puts "Pass time for the first function: #{current - old}"
