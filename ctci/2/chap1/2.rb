def if_permutation(str1, str2)
    return false if str1.length != str2.length
    # Check which letter and how many the letters are included in the string.
    counter1 = {}
    counter2 = {}
    (0..str1.length-1).each do |i|
        if counter1.key?(str1[i])
            counter1[str1[i]] += 1
        else
            counter1[str1[i]] = 1
        end
        
        if counter2.key?(str2[i])
            counter2[str2[i]] += 1
        else
            counter2[str2[i]] = 1
        end
    end

    counter1.each do |k, v|
        return false if v != counter2[k]
    end
    return true
end

puts "apple and aelpp: #{if_permutation("apple", "aelpp")}"
puts "apple and aeple: #{if_permutation("apple", "aeple")}"
