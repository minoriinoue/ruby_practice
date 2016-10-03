def check(exp, desired_result)
    if exp.length == 1
        if exp.to_i == desired_result
            return 1
        else
            return 0
        end
    end
    counter = 0
    0.step(exp.length - 3, 2) do |start_index|
        new_exp = exp.dup
        calculated = cal(new_exp, start_index)
        new_exp[start_index..start_index+2] = calculated.to_s
        counter += check(new_exp, desired_result)
    end
    return counter
end

def cal(exp, start_index)
    case exp[start_index+1]
    when '|'
        return exp[start_index].to_i | exp[start_index+2].to_i
    when '&'
        return exp[start_index].to_i & exp[start_index+2].to_i
    when '^'
        return exp[start_index].to_i ^ exp[start_index+2].to_i
    end
end

print "counter = ", check('1^0|0|1', 0), "\n"
