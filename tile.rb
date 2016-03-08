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
    elsif self.revealed
      return ' #{self.neighbor_bomb_count} '
    else
      return ' _ '
    end
  end

  def reveal
    if self.bombed
      return false
    else
      self.revealed = true
      if self.neighbor_bomb_count == 0
        self.neighbors.each do |neighbor|
          neighbor.reveal
        end
      end
    end
    true
  end

  NEIGHBOR_DELTAS = [
    [-1, -1]
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]

  def neighbors
    neighbors = []
    NEIGHBOR_DELTAS.each do |neighbor|
      dx, dy = neighbor
      if @board.in_bounds?(self.row + dx, self.col + dy)
        neighbors.append(@board[self.row + dx][self.col + dy])
      end
    end
    neighbors
  end

  def neighbor_bomb_count
    count = 0
    self.neighbors.each do |neighbor|
      count += 1 if neighbor.bombed
    end
  end
end
