def make_field(height, width, living)
    array = Array.new(height, 0)
    for i in 0..height-1
        array[i] = Array.new(width, 0)
    end

    for row in living
        array[row[0]][row[1]] = 1
    end
    return array
end
