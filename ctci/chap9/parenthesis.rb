def init(n)
    result = []
    str = ""
    index = 0
    make_parenthesis(str, index, result, n)
    p result
end

def make_parenthesis(str, index, result, n)
    if n == 0
        result << str
    else
        for i in index..str.length
            string = str.dup
            string.insert(i, "()")
            make_parenthesis(string, i+1, result, n-1)
        end
    end
end

init(3)
init(4)
