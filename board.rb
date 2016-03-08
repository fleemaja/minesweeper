require_relative 'tile.rb'

class Board
  attr_accessor :grid

  def initialize(size, num_bombs)
    @grid = Array.new(size) { Array.new(size, nil) }
    setup_board
    lay_bombs(num_bombs)
  end

  def setup_board
    @grid.each_index do |row|
      @grid.each_index do |col|
        @grid[row][col] = Tile.new(@grid, [row, col])
      end
    end
  end

  def lay_bombs(num_bombs)
    bombs_laid = 0
    while bombs_laid < num_bombs
      random_row = rand(@grid.count)
      random_col = rand(@grid.count)
      if @grid[random_row][random_col].bombed == false
        @grid[random_row][random_col].bombed = true
        bombs_laid += 1
      end
    end
  end

  def render_board
    to_render = ""
    @grid.each_index do |row|
      @grid.each_index do |col|
        to_render += @grid[row][col].draw
      end
      to_render += "\n"
    end

    print to_render
  end
end

b = Board.new(9, 2)

b.render_board
