# O(n)
def compression(str)
    result = ''
    i = 0
    while (i != str.length) do
        j = i + 1
        while str[i] == str[j] do
            j += 1
        end
        result << "#{str[i]}#{j-i}"
        i = j
    end
    if str.length < result.length
        return str
    else
        return result
    end
end

str = 'aabcccccaaa'
puts "aabcccccaaa would become #{compression(str)}"

