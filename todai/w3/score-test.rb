require('test/unit')
load('./score.rb')

class TC_SCORE < Test::Unit::TestCase
    def test_score
        # When the element of the array is sorted.
        assert_equal(9,score([1,2,3,4,5])) # 2 + 3 + 4 = 9
        # When the element of the array is not sorted.
        assert_equal(9,score([5,1,3,2,4])) # Same as above.
        # When array contains an element less than 0.
        assert_equal(9,score([5,-1,3,2,4])) # Same as above since the min does not change.
    end
end
