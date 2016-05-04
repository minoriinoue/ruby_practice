# Had difficulty in coming up with a loop invariant.
def decrypt2(s)
    a = []
    b = []
    for index in 0..s.length
        index_remainder = index % 4
        if index_remainder == 0 || index_remainder == 1
            a << s[index]
        else
            b << s[index]
        end
        # (1)
        # String s is a repitition of a group consists of
        # 4 chars. In the 4 chars, the first 2 chars should
        # belong to group a according to the problem and 
        # the mod (by 4) of their index in the string s is either 0
        # or 1. In the same way, the last 2 chars should belong
        # to group b according to the problem and the mod (by 4)
        # of their index in the string s is either 2 or 3.
        # 
        # (2)
        # In this code, array a consists of chars whose
        # index is either 0 or 1 for all index from 0 to the
        # current index. Array b consists of chars whose index
        # is either 2 or 3 for all index from 0 to the current
        # index.
        #
        # From (1), array a belongs to group a and array b belongs to
        # group b. Thus this loop invariant matches with the problem.
    end
    return [a.join, b.join]
end
