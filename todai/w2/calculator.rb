# Already checked by Prof. Kaneko.
def calculator(a, op, b)
  if op == "+"
    a+b
  elsif op == "-"
    a-b
  elsif op == "*"
    a*b
  elsif op == "/"
    a/b
  else
    "No matching operand. Only +, -, *, / are available."
  end
end
