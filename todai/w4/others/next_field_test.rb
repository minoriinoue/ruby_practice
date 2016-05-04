require('test/unit')
load('./next_field.rb')

class NF_TEST < Test::Unit::TestCase
    def test_next_field
        array_original = [[0,1,0,0,0],[0,0,1,0,0],[1,1,1,0,0],[0,0,0,0,0], [0,0,0,0,0]]
        array_expected = [[0,0,0,0,0],[1,0,1,0,0],[0,1,1,0,0],[0,1,0,0,0], [0,0,0,0,0]]
        assert_equal(array_expected, next_field(array_original))

        # When the matrix is not square.
        array_original = [[0,1],[1,1],[1,0],[1,1],[1,1]]
        array_expected = [[1,1],[1,1],[0,0],[0,0],[1,1]]
        assert_equal(array_expected, next_field(array_original))
    end
end
