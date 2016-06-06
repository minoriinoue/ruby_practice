def init(boxes)
    boxes.each do |box|
        box << False
    end
    memo = Array.new(boxes.length, nil)
    solve(boxes.length, INFINITY, INFINITY, INFINITY, boxes, memo)
end

def solve(n, prev_w, prev_h, prev_d, boxes, memo)
    return 0 if n == 0
    return memo[n] if memo[n] != nil
    max = 0
    boxes.each_with_index do |box, index|
        unless box[3] # Unless the box has not been used.
            if box[0] < prev_w &&
                box[1] < prev_h &&
                box[2] < prev_d
                boxes_new = boxes.map { |box| box.dup }
                boxes_new[index] = True
                value = box[1] +
                        solve(n-1, box[0], box[1], box[2], boxes_new, memo)
                if value > max
                    max = value
                end
            end
        end
    end
    memo[n] = max
    return memo[n]
end
