def make_node(num, left, right)
    [num, left, right]
end
def value(tree)
    tree[0]
end
def left(tree)
    tree[1]
end
def right(tree)
    tree[2]
end
# また,特殊ケースとして空の節点を nil で表わすことにする
EmptyTree = nil
def is_empty(tree)
    tree == EmptyTree
end
# 便利のために,子を持たない節点 (=葉) を作るための略記法を用意
def make_leaf(num)
    make_node(num, EmptyTree, EmptyTree)
end
