require('test/unit')
load('./extend_sum.rb')

class ES_TEST < Test::Unit::TestCase
    def test_extend_sum
        array = [[1,2,3], [4,5,6], [7,8,9]]
        result_array = [[1,2,3,6],[4,5,6,15],[7,8,9,24],[12,15,18,45]]
        assert_equal(result_array, extend_sum(array))
    
        array_2 = [[1, 2, 3], [10, 20, 30]]
        result_array_2 = [[1, 2, 3, 6], [10, 20, 30, 60], [11, 22, 33, 66]]
        assert_equal(result_array_2, extend_sum(array_2))
    end
end
