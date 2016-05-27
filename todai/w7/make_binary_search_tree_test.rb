# 金子先生のチェック済み

require('test/unit')
load('./make_binary_search_tree.rb')
load('./array_tree.rb')
load('./inorder.rb')

class MBST_TEST < Test::Unit::TestCase
    def test_make_binary_search_tree
        result = [3, [1, [0, nil, nil], [1, nil, [2, nil, nil]]], [6, [5, nil, nil], [7, nil, [9, nil, nil]]]]
        assert_equal(result, make_binary_search_tree([3,1,6,1,7,9,2,0,5]))
        confirm_asc = [0, 1, 1, 2, 3, 5, 6, 7, 9]
        assert_equal(confirm_asc, inorder(make_binary_search_tree([3,1,6,1,7,9,2,0,5])))
    end
end
