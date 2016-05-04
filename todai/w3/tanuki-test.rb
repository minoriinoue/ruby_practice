require('test/unit')
load('./tanuki.rb')

class T_TEST < Test::Unit::TestCase
    def test_tanuki
        # When all the tas are inside the string.
        assert_equal("abbtcc", erase_ta("atabbtctac"))
        # When a ta is at the front of the string.
        assert_equal("abbtcc", erase_ta("taatabbtctac"))
        # When a ta is at the last of the string.
        assert_equal("abbtc", erase_ta("atabbtcta"))
    end
end
