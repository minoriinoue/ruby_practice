# Already checked by Prof. Kaneko
def abbreviation(word)
  word[0].to_s + (word.length-2).to_s + word[word.length-1].to_s 
end
