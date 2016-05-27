require('test/unit')
load('./binary_search.rb')

class BS_TEST < Test::Unit::TestCase
    def test_bs
        a=[1,3,5,7]
        assert_equal(binary_search(a, 1, 0, a.length), 0)
        assert_equal(binary_search(a, 3, 0, a.length), 1)
        assert_equal(binary_search(a, 5, 0, a.length), 2)
        assert_equal(binary_search(a, 7, 0, a.length), 3)
        assert_equal(binary_search(a, 2, 0, a.length), -1)
    end
end
