# 足し算や九九のように、基本的なサーチアルゴリズム
# を書けるようになりたいです。。この授業が終わったあとも
# このようなアルゴリズムに慣れ親しむ授業ないですかね、、、？
def binary_search(a, x, l, r)
    m = ( l + r ) / 2
    if l + 1 == r && a[l] == x
        l
    elsif l + 1 == r && a[l] != x
        -1
    elsif l + 1 < r && a[m] > x
        binary_search(a, x, l, m)
    else
        binary_search(a, x, m, r)
    end
end
