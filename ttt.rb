require 'set'

board =
  "         |         |          \n" <<
  "         |         |          \n" <<
  "         |         |          \n" <<
  "---------+---------+----------\n" <<
  "         |         |          \n" <<
  "         |         |          \n" <<
  "         |         |          \n" <<
  "---------+---------+----------\n" <<
  "         |         |          \n" <<
  "         |         |          \n" <<
  "         |         |          "

def make_move(cell, move, board)
  cell_map =
    {1 => 35, 2 => 45, 3 => 55, 4 => 159, 5 => 169,
    6 => 179, 7 => 283, 8 => 293, 9 => 303}
  board[cell_map[cell]] = move
  board
end

# a list of open cells on the board
available_moves = [1,2,3,4,5,6,7,8,9]

# store each player's moves so that we can check for winning
# positions.
x_moves = []
o_moves = []

def check_for_winner(player_moves)
  winners =
    [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [3,5,7], [1,5,9]]
  winners.each do |w|
    if w.to_set.subset?(player_moves.to_set)
      return true
    end
  end
end

# begin the game
puts board
loop do
  # get player move
  begin
    puts "Your move? (1-9)"
    move = gets.chomp.to_i
  end until available_moves.find_index(move)

  # adjust the game state and display
  available_moves.delete(move)
  x_moves.push(move)
  board = make_move(move, 'X', board)
  puts board
  puts

  # check for winner
  if check_for_winner(x_moves) == true
    puts "You win!"
    break
  end

  # check for game over
  if available_moves == []
    puts "Tie!"
    break
  end

  # bot move
  move = available_moves.sample

  # adjust game state and display
  available_moves.delete(move)
  o_moves.push(move)
  board = make_move(move, "O", board)
  puts board
  puts

  # check for winner
  if check_for_winner(o_moves) == true
    puts "I win!"
    break
  end
end
