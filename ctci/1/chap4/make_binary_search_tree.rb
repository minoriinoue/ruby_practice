# 金子先生のチェック済み

def make_binary_search_tree(array)
    tree = nil
    array.each do |element|
        tree = add_node(tree, element)
    end
    return tree
end

def add_node(tree, x)
    if tree == nil
        return make_leaf(x)
    elsif x < value(tree)
        return make_node(value(tree), add_node(left(tree), x), right(tree))
    else
        return make_node(value(tree), left(tree), add_node(right(tree), x))
    end
end
