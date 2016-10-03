# number of 0s in factorial 4 is: 0
# number of 0s in factorial 6 is: 1
# number of 0s in factorial 10 is: 2
# number of 0s in factorial 100 is: 24
# number of 0s in factorial 1000 is: 249
# number of 0s in factorial 10000 is: 2499
# Time: 3.8e-05

def zero_in_factorial(n)
    count = 0
    return -1 if n < 0
    fives = 5
    while fives < n do
        count += (n / fives)
        fives *= 5
    end
    print "number of 0s in factorial #{n} is: #{count}\n"
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
