require "komaba/array"

load("make2d.rb")

a = make2d(100, 100)

for i in 0..99
  for j in 0..99
    a[i][j] = [rand, rand, rand]
  end
end

show(a)

