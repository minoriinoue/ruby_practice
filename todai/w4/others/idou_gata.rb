# Glider result
# 以下の4つの状態を周期としてスライドしながらずれていく
#
# [0, 1, 0]
# [0, 0, 1]
# [1, 1, 1]
#
# ここで下にずれる(行が一個全体に１つ下に遷移)
# [1, 0, 1]
# [0, 1, 1]
# [0, 1, 0]
#
# [0, 0, 1]
# [1, 0, 1]
# [0, 1, 1]
#
# ここで右にずれる(列が一個分全体に１つ右に遷移)
# [1, 0, 0]
# [0, 1, 1]
# [1, 1, 0]
#
# isrbが結局使えず、ローカルでdumpして周期などをチェックしました。笑
# (なので、demoにはsleepの後に毎回dumpするためにshowが呼ばれています。)
# 0,1を解す目が必要だったことが一番辛かったかもしれません。^^
#

load('./next_field.rb')
load('./make_field.rb')
def update(src, dst)
    for r in 0..src.length-1
        for c in 0..src[r].length-1
            dst[r][c] = src[r][c]
        end
    end
end

def demo(initial,step)
    field = initial
    show(field)
    for t in 1..step
        print "---------\n"
        new_field = next_field(field)
        update(new_field, field)
        sleep 1.0
        show(field)
    end
end

def show(a)
    for row in a
        print row, "\n"
    end
end

