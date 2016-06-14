require('test/unit')
load('./clock_timer.rb')

class CLOCK_TIMER_TEST < Test::Unit::TestCase
    def test_clock_timer
        clock_timer = ClockTimer.new(22, 54, 14)
        assert_equal(22, clock_timer.hour)
        assert_equal(54, clock_timer.minute)
        assert_equal(14, clock_timer.second)
        # tick once and check hour, minute, and second.
        assert_equal(15, clock_timer.tick)
        assert_equal(22, clock_timer.hour)
        assert_equal(54, clock_timer.minute)
        assert_equal(15, clock_timer.second)

        45.times { clock_timer.tick }
        assert_equal(22, clock_timer.hour)
        assert_equal(55, clock_timer.minute)
        assert_equal(0, clock_timer.second)

        (60 * 5).times { clock_timer.tick }
        assert_equal(23, clock_timer.hour)
        assert_equal(0, clock_timer.minute)
        assert_equal(0, clock_timer.second)
    end
end
