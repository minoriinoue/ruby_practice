# Already checked by Prof. Kaneko.
def in_rectangle(w,h,x,y,r)
  if (x + r) <= w && (x - r) >= 0 && (y + r) <= h && (y - r) >= 0
    true
  else
    false
  end
end
