# number of 0s in factorial 4 is: 0
# number of 0s in factorial 6 is: 1
# number of 0s in factorial 10 is: 2
# number of 0s in factorial 100 is: 24
# number of 0s in factorial 1000 is: 249
# number of 0s in factorial 10000 is: 2499
# Time: 0.006544

def zero_in_factorial(n)
    arr = Array.new(n) {|index| index + 1}
    print "number of 0s in factorial #{n} is: #{rec(arr)}\n"
end

def rec(arr)
    return 0 if arr.length == 1
    new_arr = []
    sum = 0
    i = 0
    while i <= arr.length-2 do
        new_num = arr[i] * arr[i+1]
        if new_num % 10 == 0
            sum += 1
            new_num = new_num / 10
        end
        new_arr << new_num
        i += 2 #To get 2 elements each.
        # E.g. arr[0] * arr[1] -> [next] arr[2] * arr[3]
    end
    if arr.length % 2 == 1
        new_arr << arr[arr.length-1]
    end
    return sum + rec(new_arr)
end
t1 = Time.now
zero_in_factorial(4)
zero_in_factorial(6)
zero_in_factorial(10)
zero_in_factorial(100)
zero_in_factorial(1000)
zero_in_factorial(10000)
t2 = Time.now
puts "Time: #{t2 - t1}"
