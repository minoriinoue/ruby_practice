load('./linked_list.rb')

# Problem was different
def find_kth(list, k)
    result = []
    while list != nil do
        result << list.value
        list = list.next
    end
    result.sort!
    return result[result.length - k]
end

arr = [3,1,2,1,4,5,1,2,6]
list = generate_desire_list(arr)
puts find_kth(list, 3)
sorted_array = arr.sort
puts "sorted_array: #{sorted_array}"
