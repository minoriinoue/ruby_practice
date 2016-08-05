# 問題名：複数のobserver
#
# ConsoleClock.new(timer)を3回行い、observerを３人に増やして見た
# 
# そのときのtimer.tick()の結果は、
# 22:55:56
# 22:55:56
# 22:55:56
# と同じ時刻が３回ちゃんと表示された。

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
        notify()
    end
end
class ConsoleClock < Observer
    def initialize(subject)
        super()
        @subject = subject
        @subject.attach(self)
    end
    def clock_to_string(clock)
        sprintf("%02d:%02d:%02d", clock.hour, clock.minute, clock.second)
    end
    def update
        puts clock_to_string(@subject)
    end
end
