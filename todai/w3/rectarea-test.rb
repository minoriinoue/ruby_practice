require('test/unit') # 定型句
load('./rectarea.rb') # テストする関数を含むファイル名を指定
class TC_Area < Test::Unit::TestCase # 定型句 def test_area # 名前を"test "で始める
    def test_area
        assert_equal(15, rectarea(5,3))
        assert_equal(200, rectarea(10,20))
    end
end
