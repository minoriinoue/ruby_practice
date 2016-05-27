# absを最初忘れかけたので、最初から正しくかけるように訓練したいです。

include Math

Epsilon = 0.0001
def sigmoid_inverse(y, a, b)
    middle_point = (a + b) / 2.0
    difference = y - 1.0 / (1.0 + exp(-1.0 * middle_point))
    if difference.abs < Epsilon
        middle_point
    elsif difference > 0.0
        # Since sigmoid function monotonically increases,
        # the difference (i.e. y - sigmoid) becomes more
        # than 0 when middle point is smaller than the solution.
        sigmoid_inverse(y, middle_point, b)
    else
        sigmoid_inverse(y, a, middle_point)
    end
end
