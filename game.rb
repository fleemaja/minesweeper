require_relative 'board.rb'

class Game
  def initialize(size_of_board, num_bombs)
    @board = Board.new(size_of_board, num_bombs)
  end

  def play
    until (@board.won? || @board.lost?)
      @board.render_board
      print "\nEnter 'f' for flag or 'r' for reveal and then enter a row, col (i.e r or f, row, col)"

      action, row, col = get_move
      perform_move(action, row, col)

      @board.grid[row][col].reveal
    end

    if @board.won?
      puts "You win!"
    elsif @board.lost?
      puts "Bomb hit!"
      @board.reveal
      @board.render_board
    end
  end

  private

      def get_move
        action_type, row_s, col_s = gets.chomp.split(",")

        [action_type, row_s.to_i, col_s.to_i]
      end

      def perform_move(flag_or_reveal, row, col)
        tile = @board.grid[row][col]

        case flag_or_reveal
        when "f"
          tile.toggle_flag
        when "r"
          tile.reveal
        end
      end
end

g = Game.new(9, 5)

g.play
