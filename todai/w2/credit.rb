# Already checked by Prof.Kaneko.
def issueCC(dt, dl, ic)
  tmp = dt.to_f / ic.to_f
  if tmp >= 0.28
    return false
  elsif tmp >= 0.2 && tmp < 0.28
    if dl >= 1
      return false
    else
      if ic >= 3000000
        return true
      else
        return false
      end
    end
  else
    if dl >= 2
      return false
    elsif dl == 1
      if ic >= 5000000
        return true
      else
        return false
      end
    else
      if ic >= 3000000
        return true
      else
        return false
      end
    end
  end
end
