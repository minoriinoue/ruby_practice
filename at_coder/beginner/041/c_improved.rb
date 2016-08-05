n = gets.chomp.to_i
n = gets.chomp.split.map.with_index { |e, i| [i, e.to_i] }
n.sort! {|e1, e2| e2[1] <=> e1[1]}
n.each do |arr|
        puts arr[0] + 1
end
