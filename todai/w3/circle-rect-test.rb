require('test/unit')
load('./circle-rect.rb')

class TC_CR < Test::Unit::TestCase
    def test_circle_rect
        # When the circle is completely in the rectangle
        assert_equal(true, in_rectangle(5, 6, 3, 3, 2))
        # When the circle is completely outside the rectangle.
        assert_equal(false, in_rectangle(5, 6, 10, 3, 2))
        # When the circle has intersection with the upper line of the rectangle.
        assert_equal(false, in_rectangle(5, 6, 3, 5, 2))
        # When the circle has intersection with the botton line of the rectangle.
        assert_equal(false, in_rectangle(5, 6, 3, 1, 2))
        # When the circle has intersection with the right line of the rectangle.
        assert_equal(false, in_rectangle(5, 6, 4, 3, 2))
        # When the circle has intersection with the left line of the rectangle.
        assert_equal(false, in_rectangle(5, 6, 1, 3, 2))
    end
end
