require('test/unit')
load('./merge_sort.rb')

class MS_TEST < Test::Unit::TestCase
    def test_merge_sort
        assert_equal(merge_sort([8,3,4,1,5,9,6,7,2]),[1, 2, 3, 4, 5, 6, 7, 8, 9])
        assert_equal(merge_sort([1]), [1])
        assert_equal(merge_sort([]), [])
    end
end
