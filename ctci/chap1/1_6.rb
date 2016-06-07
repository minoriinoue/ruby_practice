# O(n^2): We have to touch all the elements at least once.
def rotate(matrix)
    num_iter = matrix.length / 2
    num_element_per_bar = matrix.length
    for i in 1..num_iter do
        j = 0
        while (j < num_element_per_bar - 1) do
            tmp = matrix[i-1 + j][i-1]
            matrix[i-1 + j][i-1] = matrix[matrix.length - i][i - 1 + j]
            matrix[matrix.length - i][i - 1 + j] = matrix[matrix.length - i - j][matrix.length - i]
            matrix[matrix.length - i - j][matrix.length - i] = matrix[i-1][i-1 + (num_element_per_bar - j - 1)]
            matrix[i-1][i-1 + (num_element_per_bar - j - 1)] = tmp
            
            j += 1
        end
        num_element_per_bar -= 2
    end
    return matrix
end

matrix = []
for i in 1..4 do
    arr = []
    for j in 4*(i-1)+1..4*i do
        arr << j
    end
    matrix << arr
end
puts "original matirx: #{matrix}"
puts "90 degree rotated: #{rotate(matrix)}"
