# インデックスと値が違い、valueをそのグループ内で且つ交換すると、indexと同じになる
# 組み合わせを考えれば良い
n = gets.to_i
num_arr = gets.chomp.split(" ").map(&:to_i)
cp_num_arr = num_arr.dup
result = 0
index = 0
start_index = 0
while cp_num_arr.length != 0 do
  cp_num_arr.delete(num_arr[index])
  index = num_arr.at(index) - 1
  if index == start_index
    result += 1
    index = num_arr.find_index(cp_num_arr.first)
    start_index = index
  end
end
puts result
