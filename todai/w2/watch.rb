# Already checked by Prof.Kaneko
def watch(s)
  hour = s / (60 * 60)
  minute = (s - hour * 60 * 60) / 60
  second = s - hour * 60 * 60 - minute * 60
  hour.to_s + ":" + minute.to_s + ":" + second.to_s
end
