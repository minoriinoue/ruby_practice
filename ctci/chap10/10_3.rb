def find_element_in_rotated_array(arr, start_index, end_index, key)
    return -1 if start_index > end_index # Could not find the element

    half_index = (start_index + end_index) / 2
    if arr[half_index] == key
        return half_index
    elsif arr[start_index] > arr[half_index]
        # half_index to last_index are normally sorted.
        if key >= arr[half_index + 1] && key <= arr[end_index]
            return find_element_in_rotated_array(arr, half_index + 1, end_index, key)
        else
            return find_element_in_rotated_array(arr, start_index, half_index - 1, key)
        end
    else
        # start_index to hald_index are normally sorted.
        if key >= arr[start_index] && key <= arr[half_index - 1]
            return find_element_in_rotated_array(arr, start_index, half_index - 1, key)
        else
            return find_element_in_rotated_array(arr, half_index + 1, end_index, key)
        end
    end
end

arr = [15,16,19,20,25,1,3,4,5,7,10,14]
puts find_element_in_rotated_array(arr, 0, arr.length - 1, 5)
arr1 = [1,2,3,4,5,6,7,8,9,10]
puts find_element_in_rotated_array(arr1, 0, arr1.length - 1, 5)
