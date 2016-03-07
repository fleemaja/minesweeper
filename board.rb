class Board
  attr_accessor :grid

  def initialize(size, num_bombs)
    @grid = Array.new(size) { Array.new(size, "_") }
    setup_board(num_bombs)
  end

  def setup_board(num_bombs)
    bombs_laid = 0
    while bombs_laid < num_bombs
      random_row = rand(@grid.count)
      random_col = rand(@grid.count)
      if @grid[random_row][random_col] != "B"
        @grid[random_row][random_col] = "B"
        bombs_laid += 1
      end
    end
  end
end
