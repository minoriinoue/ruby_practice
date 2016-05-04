# Had difficulty in coming up with loop invariant.
# I thought I always wrote code without so much thinking
# how correct the code is.
def erase_ta(x)
    index = 0
    index_to_remove = []
    while index < x.length do
        if x[index] == 't'
            if x[index+1] == 'a'
                index_to_remove << index
                # index_to_remove is the array of indexes whose char
                # at string x is 't' and whose next index's char is 'a'
                # among the indexes from 0 to the current one.
            end
        end
        index += 1
    end

    index = 0
    answer_separated = []
    index_to_remove.each do |index_to_remove|
        answer_separated << x[index, index_to_remove - index]
        # answer_separated is the array of strings. Each element
        # is a string from an index to the next 'ta'. Since the index
        # is either 0 (at the beginning) or one just after 'ta' up to
        # the current index,
        # answer_separated is the group of strings extracted from string
        # x between the index right after previous 'ta' and the index right
        # after the next 'ta' and deprived of 'ta', up to the current index,
        # and ordered by original string's index in a ascending order.
        index += (index_to_remove - index) + 2
    end
    answer_separated << x[index, x.length - index]

    answer = answer_separated.join
end
