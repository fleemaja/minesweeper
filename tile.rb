class Tile
  attr_accessor :flagged, :bombed, :revealed

  def initialize(board, position)
    @board = board
    @row = position[0]
    @col = position[1]
    @flagged = false
    @bombed = false
    @revealed = false
  end

  def draw
    if self.bombed
      return ' B '
    else
      return ' _ '
    end
  end

  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end
end
