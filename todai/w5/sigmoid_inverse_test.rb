# 何故かassert_in_deltaでなくて良かったのですが、
# 何故でしょう。。気になります。

require('test/unit')
load('./sigmoid_inverse.rb')

class SI_TEST < Test::Unit::TestCase
    def test_sigmoid_inverse
        assert_equal(sigmoid_inverse(0.5, -10, 10), 0.0)
        assert_equal(sigmoid_inverse(0.2, -10, 10), -1.38671875)
        assert_equal(sigmoid_inverse(0.1, -10, 10), -2.197265625)
        assert_equal(sigmoid_inverse(0.9, -10, 10), 2.197265625)
    end
end
