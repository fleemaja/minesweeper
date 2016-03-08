require_relative 'tile.rb'

class Board
  attr_accessor :grid

  def initialize(size, num_bombs)
    @grid = Array.new(size) { Array.new(size, nil) }
    @num_bombs = num_bombs
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
    to_render = "    0  1  2  3  4  5  6  7  8 \n"
    @grid.each_index do |row|
      to_render += " #{row.to_s} "
      @grid.each_index do |col|
        to_render += @grid[row][col].draw
      end
      to_render += " #{row.to_s} "
      to_render += "\n"
    end
    to_render += "    0  1  2  3  4  5  6  7  8  "

    print to_render
  end

  def won?
    revealed_count = @grid.flatten.select { |tile| tile.revealed }.count
    if (@grid.count - @num_bombs) == revealed_count
      return true
    else
      return false
    end
  end

  def lost?
    @grid.flatten.any? { |tile| tile.revealed && tile.bombed }
  end

  def reveal
    @grid.each_index do |row|
      @grid.each_index do |col|
        @grid[row][col].revealed = true
      end
    end
  end
end
