require('test/unit')
load('./digit-sum.rb')

class TC_DC < Test::Unit::TestCase
    def test_digit_sum
        assert_equal(6,digit_sum(123))
        assert_equal(7,digit_sum(7))
    end
end
