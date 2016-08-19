require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if board.winner.nil?

  end

  def winning_node?(evaluator)
    return false if board.winner.nil?
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_array = []
    @board.each_with_index do |row, i|
      row.each_with_index do |pos, j|
        next unless @board[i,j].empty?
        duped_board = @board.dup
        duped_board[i,j] = @next_mover_mark
        children_array << duped_board
      end
    end
    switch_mark
    children_array
  end

  def switch_mark
    @prev_move_pos = @next_mover_mark
    if @next_mover_mark == :x
      @next_mover_mark = :o
    else
      @next_mover_mark = :x
    end
  end
end
