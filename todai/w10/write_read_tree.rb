# メソッドは問題なく使用できたが、JSONが実社会の中でどのように使われているか
# などの醍醐味があまりわからなかった。
#
# write_treeをしたときのtxtの中身
# {"question":"駒場の理系","yes_branch":{"question":"学際科学科所属","yes_branch":{"question":"この授業は必修","yes_branch":{"answer":"総合情報学コース"},"no_branch":{"answer":"地球システムエネルギーコース"}},"no_branch":{"answer":"統合自然科学科"}},"no_branch":{"answer":"本郷生or文系"}}
# 
# read_treeをしたときのoutput
# {"question"=>"駒場の理系", "yes_branch"=>{"question"=>"学際科学科所属", "yes_branch"=>{"question"=>"この授業は必修", "yes_branch"=>{"answer"=>"総合情報学コース"}, "no_branch"=>{"answer"=>"地球システムエネルギーコース"}}, "no_branch"=>{"answer"=>"統合自然科学科"}}, "no_branch"=>{"answer"=>"本郷生or文系"}}
# 
# 形式がjsonとhashで違うだけで、中身の木は同じ構造として出力されていることを
# 確認した。

require 'json'
load('./q_a.rb')
def write_tree(filename, tree)
    File.open(filename, 'w') do |file|
        file.puts tree.to_json
    end
end

def read_tree(filename)
    File.open(filename, 'r') do |file|
        file.each do |line|
            puts JSON.parse(line)
        end
    end
end

a_node_0 = make_answer_node('総合情報学コース')
a_node_1 = make_answer_node('地球システムエネルギーコース')
t0 = make_question_node('この授業は必修', a_node_0, a_node_1)
a_node_3 = make_answer_node('統合自然科学科')
t1 = make_question_node('学際科学科所属', t0, a_node_3)
a_node_4 = make_answer_node('本郷生or文系')
t2 = make_question_node('駒場の理系', t1, a_node_4)
write_tree('bt_qa.txt', t2)
read_tree('bt_qa.txt')
