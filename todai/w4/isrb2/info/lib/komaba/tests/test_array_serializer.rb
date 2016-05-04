require "test/unit"
require "komaba/array_serializer"

module Komaba

  class TestArraySerializer < Test::Unit::TestCase

    def test_serialize
      # 1D
      data = ArraySerializer.serialize([]).unpack("aaCSC*")
      assert_equal ["a", "s", 1, 0], data
      data = ArraySerializer.serialize([0, 0.5, 1]).unpack("aaCSC*")
      #assert_equal ["a", "s", 1, 3, (7 << 4 | 0), 15], data
      assert_equal ["a", "s", 1, 3, 0x00, 0x7f, 0xff], data
      # 2D
      data = ArraySerializer.serialize([[0, 0.25], [0.5, 0.75], [1, 0]]).unpack("aaCS2C*")
      assert_equal ["a", "s", 2, 3, 2, 0x00, 0x3f, 0x7f, 0xbf, 0xff, 0x00], data      
      #assert_equal ["a", "s", 2, 3, 2, (3 << 4 | 0), (11 << 4 | 7), 15], data
      # 3D
      data = ArraySerializer.serialize([[[0, 1], [0.25, 0.75]], [[0.5, 0.5], [0.75, 0.25]]]).unpack("aaCS3C*")
      assert_equal ["a", "s", 3, 2, 2, 2, (15 << 4 | 0), (11 << 4 | 3), (7 << 4 | 7), (3 << 4 | 11)], data
    end

    def test_deserialize
      arr1 = [0, 0.5, 1]
      str = ArraySerializer.serialize(arr1)
      arr2 = ArraySerializer.deserialize(str)
      assert_equal 3, arr2.size
      arr2.each_with_index do |val, i|
        assert_in_delta arr1[i], val, 1.0 / 256.0
      end

      arr1 = [[0, 0.25], [0.5, 0.75], [1, 0]]
      str = ArraySerializer.serialize(arr1)
      arr2 = ArraySerializer.deserialize(str)
      assert_equal 3, arr2.size
      assert_equal 2, arr2[0].size
      arr2.each_with_index do |row, j|
        row.each_with_index do |val, i|
          assert_in_delta arr1[j][i], val, 1.0 / 256.0
        end
      end

      arr1 = [[[0, 1], [0.25, 0.75]], [[0.5, 0.5], [0.75, 0.25]]]
      str = ArraySerializer.serialize(arr1)
      arr2 = ArraySerializer.deserialize(str)
      assert_equal 2, arr2.size
      assert_equal 2, arr2[0].size
      assert_equal 2, arr2[0][0].size
      arr2.each_with_index do |row1, k|
        row1.each_with_index do |row2, j|
          row2.each_with_index do |val, i|
            assert_in_delta arr1[k][j][i], val, 1.0 / 16.0
          end
        end
      end

    end

    def test_dimension
      assert_equal 1, ArraySerializer.dimension([])
      assert_equal 1, ArraySerializer.dimension([1, 1])
      assert_equal 2, ArraySerializer.dimension([[1, 1], [1, 1]])
      assert_equal 2, ArraySerializer.dimension([[1], [1, 1]])
      assert_equal 2, ArraySerializer.dimension([[1], [1, 1], []])
      assert_equal 2, ArraySerializer.dimension([[1], 1, [1]])
      assert_equal 3, ArraySerializer.dimension([[[1]], [[1]], [[1]]])
      assert_equal 3, ArraySerializer.dimension([[1], [[1]], [[1]]])
      assert_equal 3, ArraySerializer.dimension([[1, 1], [[1, 1]], [[1, 1]]])
      a = []
      a[0] = a
      assert_raise SystemStackError do
        assert_equal 1, ArraySerializer.dimension(a)
      end
    end

    def test_regular?
      assert_equal true, ArraySerializer.regular?([])
      assert_equal true, ArraySerializer.regular?([0.5, 1])
      assert_equal true, ArraySerializer.regular?([1, 1])
      assert_equal true, ArraySerializer.regular?([[1, 1], [1, 1]])
      assert_equal false, ArraySerializer.regular?([[1], [1, 1]])
      assert_equal false, ArraySerializer.regular?([[1], [1, 1], []])
      assert_equal false, ArraySerializer.regular?([[1], 1, [1]])
      assert_equal true, ArraySerializer.regular?([[[1]], [[1]], [[1]]])
      assert_equal false, ArraySerializer.regular?([[1], [[1]], [[1]]])
      assert_equal false, ArraySerializer.regular?([[1, 1], [[1, 1]], [[1, 1]]])
      assert_equal true, ArraySerializer.regular?([[[1, 1]], [[1, 1]], [[1, 1]]])
    end

  end
end

