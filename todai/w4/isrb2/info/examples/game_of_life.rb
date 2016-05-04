require "komaba/array"

def make_array(height, width)
  a = Array.new(height)
  for row in 0..width-1
    a[row] = Array.new(width)
  end
  a
end

def put_initialize_cells(a)
  for row in 0..a.size-1
    for col in 0..a[row].size-1
      a[row][col] = rand(2) # 0 or 1
    end
  end
end

def count(board, row, col)
  height = board.size
  width = board[0].size

  r = 0
  r = r + board[(row-1) % height][(col-1) % width]
  r = r + board[(row-1) % height][col]
  r = r + board[(row-1) % height][(col+1) % width]
  r = r + board[row][(col-1) % width]
  r = r + board[row][(col+1) % width]
  r = r + board[(row+1) % height][(col-1) % width]
  r = r + board[(row+1) % height][col]
  r = r + board[(row+1) % height][(col+1) % width]

  r
end

def alive(now, lives)
  if lives <= 1
    0
  elsif lives == 2
    now
  elsif lives == 3
    1
  else
    0
  end
end

def copy_array(dst, src)
  for row in 0..src.size-1
    for col in 0..src[row].size-1
      dst[row][col] = src[row][col]
    end
  end
end

width = 50
height = 50

board = make_array(height, width)
next_board = make_array(height, width)

put_initialize_cells(board)

puts "Press Ctrl+C to exit."

while true
  show(board)
  checkpoint_a()
  for row in 0..height-1
    for col in 0..width-1
      lives = count(board, row, col)
      next_board[row][col] = alive(board[row][col], lives)
    end
  end
  copy_array(board, next_board)
end
