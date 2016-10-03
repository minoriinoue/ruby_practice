def init
    result = []
    pattern = []
    (0..7).each do
        pattern << Array.new(8, -1)
    end
    sub(pattern, 0, result)
    print result
end

def sub(pattern, row_index, result)
    if row_index == 8 # Finished searching patterns.
        result << convert_to_array(pattern, result)
    else

        for i in 0..7
            ptn = pattern.map { |r| r.dup }
            if ptn[row_index][i] == -1
                ptn[row_index][i] = 1
                cross_out(ptn, row_index, i)
                if_feasible = if_feasible(ptn)
                if if_feasible
                    sub(ptn, row_index + 1, result)
                end
            end
        end
    end
end

def print_array(array)
  array.each do |arr|
    p arr
  end
end

def convert_to_array(pattern, result)
    return pattern.map { |row| row.index(1) }
end

def cross_out(pattern, row_index, i)
    for j in 0..7
        unless j == i
            pattern[row_index][j] = 0
        end

        diff = j - row_index
        if diff == 0
            next
        end
        pattern[row_index + diff][i] = 0
        pattern[row_index + diff][i+diff] = 0 if 0 <= i + diff && i + diff <= 7
        pattern[row_index + diff][i-diff] = 0 if 0 <= i - diff && i - diff <= 7
    end
end

def if_feasible(pattern)
    pattern.each do |row|
        result = row.all? { |element| element == 0 }
        return false if result
    end
    return true
end

init()
