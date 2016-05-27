# 金子先生にチェックしてもらい済み

require('test/unit')
load('./max_value.rb')
load('./array_tree.rb')

class MV_TEST < Test::Unit::TestCase
    def test_max_value
        t0 = make_leaf(2)
        t1 = make_node(1, make_leaf(3), make_leaf(5))
        t2 = make_node(3, t1, t0)
        assert_equal(2, max_value(t0))
        assert_equal(5, max_value(t1))
        assert_equal(5, max_value(t2))
    end
end
