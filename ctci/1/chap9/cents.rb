# Ctci 9.8

def init(n)
    kind = [25 , 10, 5, 1]
    memo = []
    for i in 0..kind.length
        memo << Array.new(n, nil)
    end
    print cents(n, 0, kind, memo)
end

def cents(n, kind_index, kind, memo)
    return 1 if n == 0 || kind_index == kind.length - 1
    return memo[kind_index][n-1] if memo[kind_index][n-1] != nil
    i = 0
    sum = 0
    while kind[kind_index] * i <= n
        memo[kind_index][n-1] = cents(n - kind[kind_index] * i, kind_index + 1, kind, memo)
        sum += memo[kind_index][n-1]
        i += 1
    end
    return sum
end

init(25)
