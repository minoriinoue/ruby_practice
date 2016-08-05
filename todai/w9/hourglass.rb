# 問題名：砂時計
#
# 例えば：10秒計測したいとき
#  timer = ClockTimer.new(0, 0, 10)
#  cc = ConsoleClockHourGlass.new(timer)
#  10.times { timer.tick() }
#
# 結果：
# Remain Time: 00:00:09
# Remain Time: 00:00:08
# Remain Time: 00:00:07
# Remain Time: 00:00:06
# Remain Time: 00:00:05
# Remain Time: 00:00:04
# Remain Time: 00:00:03
# Remain Time: 00:00:02
# Remain Time: 00:00:01
# Remain Time: 00:00:00
# ALERM RINGING!!!! IT'S TIME!!!
#
# 例えば2：2分計測したいとき
#  timer = ClockTimer.new(0, 2, 0)
#  cc = ConsoleClockHourGlass.new(timer)
#  120.times { timer.tick() }
# 結果
# 上と同様、120回後にALERM RINGING!!!が表示される。
#


class Observer
    def update
    end
end
class Subject
    def initialize
        @observers = []
    end
    def attach(observer)
        @observers << observer
    end
    def detach(observer)
        @observers.delete(observer)
    end
    def notify
        @observers.each{ |o|
            o.update
        }
    end
end

class ClockTimer < Subject
    attr_reader :hour, :minute, :second
    def initialize(hour, minute, second)
        super()
        @hour = hour
        @minute = minute
        @second = second
    end

    def tick
        @second -= 1
        if @second == -1
            @minute -= 1
            @second = 59
        end
        if @minute == -1
            @hour -= 1
            @minute = 59
        end
        if @hour == -1
            @hour = 23
        end
        notify()
    end
end
class ConsoleClockHourGlass < Observer
    def initialize(subject)
        super()
        @subject = subject
        @subject.attach(self)
    end
    def clock_to_string(clock)
        sprintf("%02d:%02d:%02d", clock.hour, clock.minute, clock.second)
    end
    def alerm(clock)
        if clock.hour == 0 && clock.minute == 0 && clock.second == 0
            puts "ALERM RINGING!!!! IT'S TIME!!!"
        end
    end
    def update
        puts "Remain Time: #{clock_to_string(@subject)}"
        alerm(@subject)
    end
end
