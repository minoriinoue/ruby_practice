require('test/unit')
load('./prime_array.rb')

class PA_TEST < Test::Unit::TestCase
    def test_prime_array
        assert_equal([2, 3, 5, 7, 11, 13, 17, 19], prime_array(20))
    end
end
