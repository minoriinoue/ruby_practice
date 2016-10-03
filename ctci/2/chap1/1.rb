def is_unique(str)
    char_counter = Array.new(27, 0)
    (0..str.length-1).each do |index|
        counter_index = str[index].ord - 'a'.ord
        char_counter[counter_index] += 1
        return false if char_counter[counter_index] >= 2
    end
    return true
end

puts "apple, is_unique?: #{is_unique("apple")}"
puts "jap, is_unique?: #{is_unique("jap")}"
