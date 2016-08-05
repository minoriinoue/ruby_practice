# cと比べて、rubyでのファイルの書き込み、読み込みは
# かなり簡易にできるなと思った。

def write_to_file2d(filename, x, y)
    File.open(filename, 'w') do |file|
        x.each_with_index do |e, i|
            file.puts "#{e} #{y[i]}"
        end
    end
end

# Generate y array given a function
# y = sin(x) for x = 0, pi / 4, pi/2, .. 2 * pi
include Math
interval = PI / 4.0
x = []
y = []
for i in 0..8 do
    x << interval * i
    y << sin(x[i])
end

# Create a text file
write_to_file2d('sin.txt', x, y)
