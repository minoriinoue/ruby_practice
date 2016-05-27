# 金子先生のチェック済み

require('test/unit')
load('./calc.rb')
load('./class_tree.rb')

class CALC_TEST < Test::Unit::TestCase
    def test_calc
        tree = make_node("+", make_node("*", make_leaf(3), make_leaf(5)), make_leaf(2))
        assert_equal(17, calc(tree))
    end
end
