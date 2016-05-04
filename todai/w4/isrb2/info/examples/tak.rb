require "komaba/array"

def tak(x, y, z)
  if x <= y
    y
  else
    tak(tak(x - 1, y, z), tak(y - 1, z, x), tak(z - 1, x, y))
  end
end

puts tak_CS(4, 2, 0)
