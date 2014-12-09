class SplitTilesIntoSets
  def initialize(tiles)
    @tiles = tiles
  end

  def call
    @sets = []
    board = @tiles.select {|tile| tile["y"] != nil && tile["x"] != nil}

    (0..Game::BOARD_HEIGHT).each do |row_number|
      row = board.select {|tile| tile["y"] == row_number}
      return false unless split_row_into_sets(row)
    end
    @sets
  end

  private

  def split_row_into_sets(tiles)
    return true if tiles.empty?

    row = reconstruct_row(tiles)

    return false unless row

    row.chunk {|tile| tile == nil}.each do |is_nil, set|
      if !is_nil 
        @sets.push(set)
      end
    end
    true
  end

  def reconstruct_row(tiles)
    row = []

    (0..Game::BOARD_WIDTH).each do |column_number|
      column = tiles.select {|tile| tile["x"] == column_number}

      return false if column.length > 1 

      if column.empty?
        row.push(nil)
      else
        row.push(column[0])
      end
    end
    row
  end
end