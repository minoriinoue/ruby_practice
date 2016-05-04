# TRANSITION_RULE = { current_status: {number_of_alive_cells: next_status}}
TRANSITION_RULE = { 0 => {0 => 0, 1 => 0, 2 => 0, 3 => 1, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0},
                    1 => {0 => 0, 1 => 0, 2 => 1, 3 => 1, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}}

def next_field(a)
    next_status = Array.new(a.length)
    for column_index in 0..(a.length - 1)
        next_status[column_index] = Array.new(a[0].length, 0)
    end
    a.each_with_index do |row, row_index|
        row.each_with_index do |element, element_index|
            next_status[row_index][element_index] = TRANSITION_RULE[element][number_of_live_cells(a, element, row_index, element_index)]
        end
    end
    return next_status
end

def number_of_live_cells(a, element, row_index, element_index)
    number_of_live_cells = 0
    for i in -1..1 do
        for j in -1..1 do
            row_index_to_check = row_index + i
            column_index_to_check = element_index + j
            unless i == 0 && j == 0
                if if_index_in_array(a, row_index_to_check, column_index_to_check)
                    number_of_live_cells += a[row_index_to_check][column_index_to_check]
                end
            end
        end
    end
    return number_of_live_cells
end

def if_index_in_array(a, row_index_to_check, column_index_to_check)
    row_max = a.length
    column_max = a[0].length
    row_index_to_check >= 0 && row_index_to_check < row_max && column_index_to_check >= 0 && column_index_to_check < column_max
end

