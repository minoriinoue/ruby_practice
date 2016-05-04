require "komaba/array"

load("make2d.rb")

def sierpinski(r)
  a = make2d(r + 1, r + 1)
  for i in 0..r
    a[i][0] = 1
    for j in 1..(i-1)
      a[i][j] = (a[i-1][j-1] + a[i-1][j]) % 2
    end
    a[i][i] = 1
  end
  a
end

show(sierpinski(100))
