n = gets.chomp.to_i
puts "Got n"
n = gets.chomp.split.map.with_index { |e, i| [i, e.to_i] }
puts "Got a s"
n = n.flatten
puts "flattened."
n = Hash[*n]
puts "Hashed."
n = n.sort {|(k1, v1), (k2, v2)| v2 <=> v1}
puts "Sorted."
n.each do |arr|
    puts arr[0] + 1
end
