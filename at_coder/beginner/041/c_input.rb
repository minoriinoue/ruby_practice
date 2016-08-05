n = gets.chomp.to_i
File.open("#{n}_input.txt", "w") do |f|
    f.puts n
    (1..n).each do |e|
        f.print Random.rand(1000000000)
        unless e == n
            f.print " "
        end
    end
    f.puts "\n"
end
