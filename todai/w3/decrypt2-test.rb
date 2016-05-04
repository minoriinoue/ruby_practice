require('test/unit')
load('./decrypt2.rb')

class TC_DECRYPT < Test::Unit::TestCase
    def test_decrypt2
        assert_equal(['orange', 'decode'],decrypt2('ordeancogede'))
        assert_equal(['aa', ''],decrypt2('aa'))
        assert_equal(['', ''], decrypt2(''))
    end
end
