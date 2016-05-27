# Array を扱うので、参照で意図しない箇所でArrayが
# 変更されやしないかとビクビクしながら実装しましたが、
# 一発でいけました。再帰を息をするように実装するにはまだまだ
# 特訓が必要そうです。
def merge_sort(a)
    return a if a.length == 1 || a.length == 0

    array_length = a.length
    first_half_sorted = merge_sort(a[0..(array_length / 2 - 1)])
    second_half_sorted = merge_sort(a[(array_length / 2)..-1])

    return merge(first_half_sorted, second_half_sorted)
end

def merge(a, b)
    c = []
    a_index = 0
    b_index = 0
    while a_index != a.length && b_index != b.length
        if a[a_index] < b[b_index]
            c << a[a_index]
            a_index += 1
        else
            c << b[b_index]
            b_index += 1
        end
        # array a and b are already sorted.
        # The elements from array a and b are stored in c
        # in the ascedngin order.
    end

    if a_index == a.length && b_index != b.length
        c += b[b_index..-1]
    elsif a_index != a.length && b_index == b.length
        c += a[a_index..-1]
    end
    return c
end
