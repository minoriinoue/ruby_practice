require "komaba/array"

load("make2d.rb")

a = make2d(200, 200)

for i in 0..199
  for j in 0..199
    a[i][j] = rand(2)
  end
end

show(a)
