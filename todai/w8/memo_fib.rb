# クラスにしてインスタンス変数にすると、
# 再帰においてこれまでのように何回も配列を渡す、
# などをしなくてよくて、より簡潔に書けて好きでした。

load('./counter.rb')

class MemoFib
    def initialize
        @memo = {0 => 0, 1 => 1}
        @counter = Counter.new
        # For 0 and 1
        @counter.increment
        @counter.increment
    end

    def fib(n)
        return @memo[n] if @memo.key?(n)
        @counter.increment
        @memo[n] = fib(n-1) + fib(n-2)
        return @memo[n]
    end

    def counter
        @counter.counter
    end
end

