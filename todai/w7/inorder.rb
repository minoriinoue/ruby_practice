# 金子先生のチェック済み
def inorder(tree)
    return [] if tree == nil
    return inorder(left(tree)) + [value(tree)] + inorder(right(tree))
end
