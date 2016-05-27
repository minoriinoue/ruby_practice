# 金子先生にチェックしてもらい済
def max_value(tree)
    return -1 if tree == nil
    [value(tree), max_value(left(tree)), max_value(right(tree))].max
end
