require('test/unit')
load('./lucky_array.rb')

class LA_TEST < Test::Unit::TestCase
    def test_lucky_array
        lucky_numbers = Array.new(22, false)
        lucky_numbers[7] = true
        lucky_numbers[14] = true
        lucky_numbers[16] = true # 1 + 6 = 7
        lucky_numbers[21] = true
        assert_equal(lucky_numbers, lucky_array(22))
    end
end
