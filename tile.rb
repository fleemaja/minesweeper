class Tile
  attr_accessor :flagged, :bombed, :revealed
  
  def initialize(board, position)
    @board = board
    @position = position
    @flagged = false
    @bombed = false
    @revealed = false
  end

  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end
end
