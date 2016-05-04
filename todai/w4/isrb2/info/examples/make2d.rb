def make2d(height, width)
  a = Array.new(height)
  for i in 0..(height - 1)
    a[i] = Array.new(width)
    for j in 0..(width - 1)
      a[i][j] = 0
    end
  end
  a
end
