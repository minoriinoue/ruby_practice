require "komaba/array"

load("make2d.rb")

a = make2d(7, 7)

show_object(a)

for i in 1..6
  a[i][0] = 1
  show_object(a)
  for j in 1..(i-1)
    a[i][j] = a[i-1][j-1] + a[i-1][j]
    show_object(a)
  end
  a[i][i] = 1
  show_object(a)
end
