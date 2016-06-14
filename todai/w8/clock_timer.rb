# tickの繰り上がりの際に、-= 60や、-= 24をしているが、
# 0を代入した方がリセットされる概念とタイアップしてベター
# かもしれないと思った。
class ClockTimer
    attr_reader :hour, :minute, :second
    def initialize(hour, minute, second)
        @hour = hour
        @minute = minute
        @second = second
    end

    def tick
        @second += 1
        if @second == 60
            @minute += 1
            @second -= 60
        end
        if @minute == 60
            @hour += 1
            @minute -= 60
        end
        if @hour == 24
            @hour -= 24
        end
        return @second
    end
end
