def prime_array(n)
    all_numbers = Array.new(n, true)
    all_numbers[0] = false
    all_numbers[1] = false
    max_check_number = Math.sqrt(n).floor
    for i in 2..max_check_number do
        if all_numbers[i]
            multiple_counter = 2
            multiple_of_i = i * multiple_counter
            multiple_counter += 1
            while multiple_of_i < n do
                all_numbers[multiple_of_i] = false
                multiple_of_i *= multiple_counter
                multiple_counter += 1
            end
        end
        # Array all_numbers is a group of boolean elements with
        # length of the number a user gives. False elements in
        # the array are the group of array elements whose index
        # is multiple of a number in 2 .. i.
    end
    
    result = []
    all_numbers.each_with_index do |element, index|
        # The true elements in all_numbers are the ones whose
        # index is not multiple of any number between 2 to n.
        # Thus, the true elements are prime numbers.
        result << index if element
    end
    result
end
