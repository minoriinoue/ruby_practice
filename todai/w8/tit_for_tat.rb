# TitForTatと他のPlayerの対戦結果で気づいたこと
# vs. CooperatePlayer: 常にお互い協調するので、常に報酬の和は最大となる
# vs. DefectPlayer: 一回目にTitForTatが協調する以外はお互いに欺き合うので、
#                   両者の報酬の和は小さくなるが、どちらか一方が極端に損を
#                   することはなくなる。
# vs. RandomPlayer: 極端にTitForTatが損をすることはない。引き分けか、
#                    TitForTatが3点少なくなるか程度である。
# vs. AlternatePlayer: AlternatePlayerがDefectすると、今度はTitForTatが
#                      Defectし、交互にそれが起こるので、どちらかのPlayer
#                      が極端に損をすることはなくなる。事実、TitForTatが
#                      3点少ないか、引き分けとなる。

Cooperate = 0
Defect = 1
def valid_action(act)
    return act == Cooperate || act == Defect
end

Reward = [
            [2, 0], # The player cooperated.
            [3, 1], # The player betrayed.
         ]

class Player
    def name
    end
    def play
    end
    def update(my_action, op_action)
    end
end

class CooperatePlayer < Player
    def name
        'CooperatePlayer'
    end
    def play
        # Always return cooperate (0).
        Cooperate
    end
end
class DefectPlayer < Player
    def name
        'DefectPlayer'
    end
    def play
        # Always return defect (1)
        Defect
    end
end
class RandomPlayer < Player
    def name
        'RandomPlayer'
    end
    def play
        (rand(2) == 0) ? Cooperate : Defect
    end
end
class AlternatePlayer < Player
    def initialize
        @last_action = (rand(2) == 0) ? Cooperate : Defect
    end
    def name
        'AlternatePlayer'
    end
    def update(my_action, op_action)
        @last_action = my_action
    end
    def play
        if @last_action == Cooperate
            Defect
        else
            Cooperate
        end
    end
end
class TitForTatPlayer < Player
    def initialize
        @op_last_action = Cooperate
    end
    def name
        'TitForTatPlayer'
    end
    def update(my_action, op_action)
        @op_last_action = op_action
    end
    def play
        if @op_last_action == Defect
            Defect
        else
            Cooperate
        end
    end
    def init_last_action
        @op_last_action = Cooperate
    end
end

def play_one_game(player_a, player_b)
    act_a = player_a.play
    act_b = player_b.play
    raise unless valid_action(act_a)
    raise unless valid_action(act_b)
    reward_a = Reward[act_a][act_b]
    reward_b = Reward[act_b][act_a]

    player_a.update(act_a, act_b)
    player_b.update(act_b, act_a)

    [act_a, reward_a, act_b, reward_b]
end

P = 1.0 / 8
def play_games(player_a, player_b)
    player_a.init_last_action if player_a.name == 'TitForTatPlayer'
    player_b.init_last_action if player_b.name == 'TitForTatPlayer'
        
    sum = [0, 0] # a's point, b's point
    history = ['', ''] # Store a and b's choices in a string.
    while true do
        act_a, reward_a, act_b, reward_b = play_one_game(player_a, player_b)
        sum[0] += reward_a
        sum[1] += reward_b
        history[0] += act_a.to_s
        history[1] += act_b.to_s
        break if (rand() < P)
    end
    p [sum, history]
end
