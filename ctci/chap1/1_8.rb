# O(n): to fine where to cut the string
def isSubstring(s1, s2)
    if s1.length != s2.length
        return false
    end
    len = s1.length
    for i in 0..len-1
        fixed_str = s1[i+1..len-1].concat(s1[0..i])
        puts "i: #{i}, fixed_str: #{fixed_str}"
        if fixed_str == s2
            return true
        end
    end
    return false
end

str1 = 'erbottlewat'
str2 = 'waterbottle'

puts "Is erbottlewat a rotation of waterbottle? #{isSubstring(str1, str2)}"

