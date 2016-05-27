def display(node)
    if is_question_node(node) then
        puts "Q: "+question_text(node)+ " ? [yn]"
        yn = gets
        if yn.downcase[0,1] == "y" then
            display(question_yes(node))
        else
            display(question_no(node))
        end
    else
        puts "---"
        puts "Answer: " + answer_text(node)
    end
end

def make_question_node(question, yes_branch, no_branch)
    [question, yes_branch, no_branch]
end

def question_text(qnode)
    qnode[0]
end

def question_yes(qnode)
    qnode[1]
end

def question_no(qnode)
    qnode[2]
end

def make_answer_node(answer)
    [answer]
end

def answer_text(anode)
    anode[0]
end

def is_question_node(node)
    if node.size == 3
        return true
    else
        return false
    end
end


# これはdisplayが動くか試した時に使用したものです。
#a_node_0 = make_answer_node('総合情報学コース')
#a_node_1 = make_answer_node('地球システムエネルギーコース')
#t0 = make_question_node('この授業は必修', a_node_0, a_node_1)
#a_node_3 = make_answer_node('統合自然科学科')
#t1 = make_question_node('学際科学科所属', t0, a_node_3)
#a_node_4 = make_answer_node('本郷生or文系')
#t2 = make_question_node('駒場の理系', t1, a_node_4)
#display(t2)
