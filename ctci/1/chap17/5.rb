def count(guess, solution)
    guess_char_counter = {'R' => 0, 'Y' => 0, 'G' => 0, 'B' => 0}
    solution_char_counter = {'R' => 0, 'Y' => 0, 'G' => 0, 'B' => 0}
    hit_counter = 0
    for i in 0..3 do
        if guess[i] == solution[i]
            hit_counter += 1
        else
            guess_char_counter[guess[i]] += 1
            solution_char_counter[solution[i]] += 1
        end
    end
    pseudo_hit_counter = 0
    guess_char_counter.each do |k, v|
        min = [v, solution_char_counter[k]].min
        pseudo_hit_counter += min
    end
    return [hit_counter, pseudo_hit_counter]
end

puts "RGBY, GGRR: #{count('RGBY', 'GGRR')}"
puts "GGRR, GGRR: #{count('GGRR', 'GGRR')}"
puts "GGGR, GGRG: #{count('GGGR', 'GGRG')}"
