require('test/unit')
load('./factor.rb')

class TC_F < Test::Unit::TestCase
    def test_factor
        assert_equal([1,2,4,8], factor(8))
        assert_equal(false, factor(0))
        assert_equal(false, factor(-1))
    end
end
