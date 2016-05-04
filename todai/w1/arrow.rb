// Already checked by Prof.Kaneko
N = 4

for i in 1..(2*N+1)
    if (2 * i - 1) <= 2*N + 1
        for j in 1..(((2*N+1)-(2*i-1))/2)
            print " "
        end

        for j in 1..(2*i-1)
            print "*"
        end

        for j in 1..(((2*N+1)-(2*i-1))/2)
            print " "
        end
        print "\n"
    else
        for j in 1..((2*N+1)-1)/2
            print " "
        end

        print "*"

        for j in 1..((2*N+1)-1)/2
            print " "
        end
        print "\n"
    end
end

