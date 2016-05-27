# 金子先生のチェック済み

require('test/unit')
load('./inorder.rb')
load('./array_tree.rb')

class IO_TEST < Test::Unit::TestCase
    def test_inorder
        t0 = make_leaf(2)
        t1 = make_node(1, make_leaf(3), make_leaf(5))
        t2 = make_node(3, t1, t0)
        assert_equal([2], inorder(t0))
        assert_equal([3,1,5], inorder(t1))
        assert_equal([3,1,5,3,2], inorder(t2))
    end
end
