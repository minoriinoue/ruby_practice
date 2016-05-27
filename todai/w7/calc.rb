# 金子先生のチェック済み

def calc(tree)
    left = left(tree)
    right = right(tree)
    case value(tree)
    when "*"
        return calc(left) * calc(right)
    when "/"
        return calc(left) / calc(right)
    when "+"
        return calc(left) + calc(right)
    when "-"
        return calc(left) - calc(right)
    else # number
        return value(tree)
    end
end
