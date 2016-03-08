class Tile
  attr_accessor :flagged, :bombed, :revealed

  attr_reader :row, :col

  def initialize(board, position)
    @board = board
    @row = position[0]
    @col = position[1]
    @flagged = false
    @bombed = false
    @revealed = false
  end

  def toggle_flag
    self.flagged = !self.flagged unless self.revealed
  end

  def draw
    if !(self.revealed) && !(self.flagged)
      return ' * '
    elsif self.revealed && !(self.bombed)
      return " #{neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s} "
    elsif self.flagged
      return ' F '
    elsif self.bombed
      return ' B '
    end
  end

  def reveal
    if self.bombed
      self.revealed = true
    elsif !(self.flagged) && !(self.revealed)
      self.revealed = true
      if self.neighbor_bomb_count == 0
        self.neighbors.each do |neighbor|
          neighbor.reveal
        end
      end
    end
  end

  NEIGHBOR_DELTAS = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]

  def neighbors
    naybors = []
    NEIGHBOR_DELTAS.each do |neighbor|
      dx, dy = neighbor
      if in_bounds?(self.row + dx, self.col + dy)
        naybors.push(@board[self.row + dx][self.col + dy])
      end
    end
    naybors
  end

  def neighbor_bomb_count
    neighbors.select(&:bombed).count
  end

  def in_bounds?(row, col)
    board_size = @board.size
    if (row >= 0 && row < board_size) && (col >= 0 && col < board_size)
      return true
    else
      return false
    end
  end
end
