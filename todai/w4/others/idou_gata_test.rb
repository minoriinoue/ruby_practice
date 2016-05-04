require('test/unit')
load('./next_field.rb')
load('./make_field.rb')

class IDOU_GATA_TEST < Test::Unit::TestCase
    def test_glider
        # Test the period is 4. Since in 1 period, the pattern
        # goes to 1 column left and 1 down row. So the pattern
        # at the 1 column left and 1 down row after 1 period will
        # be same as one at the starting point.
        glider=[[0,1],[1,2],[2,0],[2,1],[2,2]]
        original = make_field(15, 15, glider)
        after_period = original.dup
        period = 4
        for i in 0..period-1
            after_period = next_field(after_period)
        end
        # Check all the elements are equal between the pattern at
        # the original point and the patter after a period which
        # [1,1] away from the original point.
        for i in 0..2
            for j in 0..2
                assert_equal(original[i][j], after_period[i+1][j+1])
            end
        end
    end
end
