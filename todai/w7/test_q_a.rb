require('test/unit')
load('q_a.rb')

class QA_TEST < Test::Unit::TestCase
    def test_qa
        a_node_0 = make_answer_node('総合情報学コース')
        a_node_1 = make_answer_node('地球システムエネルギーコース')
        t0 = make_question_node('この授業は必修', a_node_0, a_node_1)
        
        # test make_question_node
        answer = ['この授業は必修', ['総合情報学コース'], ['地球システムエネルギーコース']]
        assert_equal(answer, make_question_node('この授業は必修', a_node_0, a_node_1))

        # test question_text
        answer = 'この授業は必修'
        assert_equal(answer, question_text(t0))

        # test question_yes
        answer = a_node_0
        assert_equal(answer, question_yes(t0))

        # test question_no
        answer = a_node_1
        assert_equal(answer, question_no(t0))

        # test make_answer_node
        answer = ['総合情報学コース']
        assert_equal(answer, make_answer_node('総合情報学コース'))
        
        # test answer_text
        answer = '総合情報学コース'
        assert_equal(answer, answer_text(a_node_0))

        # test is_question_node
        assert_equal(true, is_question_node(t0))
        assert_equal(false, is_question_node(a_node_0))
    end
end
