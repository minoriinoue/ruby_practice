require "komaba/array"

load("make2d.rb")

bitmap = make2d(10, 10)

show_object(bitmap)

for i in 0..9
  for j in 0..9
    bitmap[i][j] = i*j*255/100
    show_object(bitmap)
  end
end
