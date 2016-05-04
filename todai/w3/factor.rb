# Given a piece of advice by Prof. Kaneko
# about loop invariant.
idef factor(n)
    if n <= 0
        return false
    end

    answer = []
    for i in 1..n
        if n % i == 0
            answer << i
        end
        # Answer is the group of elements which can be divided by 1..i.
    end
    return answer
end
