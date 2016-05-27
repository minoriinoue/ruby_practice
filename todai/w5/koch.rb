# point_1_3_xやyを求めるところで、基準となるx0, y0を足し忘れていて、
# 最初ピカソのようなすごい図形になりました。w
# 回転のmethodがbuilt inであると便利だなーと思いましたが、そこまででもないか。

include Math
def koch(x0, y0, x1, y1, n)
    result = [[x1, y1]]
    result += koch_except_the_last_point(x0, y0, x1, y1, n)
end
def koch_except_the_last_point(x0, y0, x1, y1, n)
    if n == 0
        [[x0,y0]]
    else
        divided_length_x = (x1 - x0) / 3.0
        divided_length_y = (y1 - y0) / 3.0
        point_1_3_x = divided_length_x * 1.0 + x0
        point_1_3_y = divided_length_y * 1.0 + y0
        point_2_3_x = divided_length_x * 2.0 + x0
        point_2_3_y = divided_length_y * 2.0 + y0
        new_vertex_x = point_1_3_x + (point_2_3_x - point_1_3_x) / 2.0 - sqrt(3.0) * (point_2_3_y - point_1_3_y) / 2.0
        new_vertex_y = point_1_3_y + sqrt(3.0) * (point_2_3_x - point_1_3_x) / 2.0 + (point_2_3_y - point_1_3_y) / 2.0

        koch_except_the_last_point(x0, y0, point_1_3_x, point_1_3_y, n-1) +
        koch_except_the_last_point(point_1_3_x, point_1_3_y, new_vertex_x, new_vertex_y, n-1) +
        koch_except_the_last_point(new_vertex_x, new_vertex_y, point_2_3_x, point_2_3_y, n-1) +
        koch_except_the_last_point(point_2_3_x, point_2_3_y, x1, y1, n-1)
    end
end
