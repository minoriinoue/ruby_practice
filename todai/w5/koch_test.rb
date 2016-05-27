# Since I did not know how to compare arrays of array in float,
# I used for-loop to compare all the element.

require('test/unit')
load('./koch.rb')

class KC_TEST < Test::Unit::TestCase
    def test_koch
        # n = 0
        answer = [[100.00000000, 0.00000000],
                 [0.00000000, 0.00000000]]
        returned_answer = koch(0.0, 0.0, 100.0, 0.0, 0) 
        answer.each_with_index do |coodination, index|
            coodination.each_with_index do |value, x_or_y|
                assert_in_delta(value, returned_answer[index][x_or_y], 0.0001)
            end
        end

        # n = 1
        answer = [[100.00000000, 0.00000000],
                  [0.00000000, 0.00000000],
                  [33.33333333, 0.00000000],
                  [50.00000000, 28.86751346],
                  [66.66666667, 0.00000000]]

        returned_answer = koch(0.0, 0.0, 100.0, 0.0, 1)
        answer.each_with_index do |coodination, index|
            coodination.each_with_index do |value, x_or_y|
                assert_in_delta(value, returned_answer[index][x_or_y], 0.0001)
            end
        end
        # n = 2
        returned_answer = koch(0.0, 0.0, 100.0, 0.0, 2)
        answer = [[100.00000000, 0.00000000],
                  [0.00000000, 0.00000000],
                  [11.11111111, 0.00000000],
                  [16.66666667, 9.62250449],
                  [22.22222222, 0.00000000],
                  [33.33333333, 0.00000000],
                  [38.88888889, 9.62250449],
                  [33.33333333, 19.24500897],
                  [44.44444444, 19.24500897],
                  [50.00000000, 28.86751346],
                  [55.55555556, 19.24500897],
                  [66.66666667, 19.24500897],
                  [61.11111111, 9.62250449],
                  [66.66666667, 0.00000000],
                  [77.77777778, 0.00000000],
                  [83.33333333, 9.62250449],
                  [88.88888889, 0.00000000]]
        answer.each_with_index do |coodination, index|
            coodination.each_with_index do |value, x_or_y|
                assert_in_delta(value, returned_answer[index][x_or_y], 0.0001)
            end
        end
    end
end
