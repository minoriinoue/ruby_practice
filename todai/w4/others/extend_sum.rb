def extend_sum(a)
    row_size = a[0].length
    new_row = Array.new(row_size + 1, 0)
    sum_of_all_elements = 0
    a.each_with_index do |row, row_index|
        sum = 0
        row.each_with_index do |element, element_index|
            sum += element
            sum_of_all_elements += element
            new_row[element_index] += element
        end
        a[row_index] << sum
    end

    new_row[row_size] = sum_of_all_elements
    a << new_row
    return a
end
