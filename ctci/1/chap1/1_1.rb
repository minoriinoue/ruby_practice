# O(nlogn:sort + n:check) ~= O(nlogn)
def if_unique_chars_by_sort(str)
    str = str.chars.sort.join
    prev = str[0]
    current_index = 1
    for index in 1..str.length-1 do
        if prev == str[index]
            return false
        end
        prev = str[index]
    end
    return true
end

# O(n)
def if_unique_chars_linear(str)
    char_counter = Array.new('z'.ord - '0'.ord, 0)
    for i in 0..str.length-1 do
        if char_counter[str[i].ord - '0'.ord] == 0
            char_counter[str[i].ord - '0'.ord] += 1
        else
            return false
        end
    end
    return true
end

def if_unique_chars_linear_by_hash(str)
    char_counter = {}
    for i in 0..str.length-1 do
        if char_counter.key?(str[i])
            return false
        else
            char_counter[str[i]] = 1
        end
    end
    return true
end
str_unique = 'Spider'
str_not_unique = 'Apple'

puts "by_sort... Spider: #{if_unique_chars_by_sort(str_unique)} Apple: #{if_unique_chars_by_sort(str_not_unique)}"
puts "linear... Spider: #{if_unique_chars_linear(str_unique)} Apple: #{if_unique_chars_linear(str_not_unique)}"
puts "linear_by_hash... Spider: #{if_unique_chars_linear(str_unique)} Apple: #{if_unique_chars_linear_by_hash(str_not_unique)}"
