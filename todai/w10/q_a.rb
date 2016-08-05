def make_question_node(question, yes_branch, no_branch)
    {'question' => question, 'yes_branch' => yes_branch, 'no_branch' => no_branch}
end

def question_text(qnode)
    qnode['question']
end

def question_yes(qnode)
    qnode['yes_branch']
end

def question_no(qnode)
    qnode['no_branch']
end

def make_answer_node(answer)
    {'answer' => answer}
end

def answer_text(anode)
    anode['answer']
end

# これはdisplayが動くか試した時に使用したものです。
a_node_0 = make_answer_node('総合情報学コース')
a_node_1 = make_answer_node('地球システムエネルギーコース')
t0 = make_question_node('この授業は必修', a_node_0, a_node_1)
a_node_3 = make_answer_node('統合自然科学科')
t1 = make_question_node('学際科学科所属', t0, a_node_3)
a_node_4 = make_answer_node('本郷生or文系')
t2 = make_question_node('駒場の理系', t1, a_node_4)
