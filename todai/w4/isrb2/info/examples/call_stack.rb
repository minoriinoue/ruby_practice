require "komaba/array"

def fib(x)
  if 1 < x
    return fib(x - 1) + fib(x - 2)
  else
    return 1
  end
end

fib_CS(10)
