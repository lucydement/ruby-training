class SplitTilesIntoSets
  InvalidTilesError = Class.new(StandardError)

  def initialize(board_tiles)
    @board_tiles = board_tiles
  end

  def call
    Game::BOARD_HEIGHT.times.flat_map do |row_number|
      row = @board_tiles.select {|tile| tile.y == row_number}
      split_row_into_sets(row)
    end
  end

  private

  def split_row_into_sets(tiles)
    reconstruct_row(tiles).
      chunk {|tile| tile.present?}.
      select {|present, _| present}.
      map {|_, tiles| tiles}
  end

  def reconstruct_row(tiles)
    Game::BOARD_WIDTH.times.map do |column_number|
      column = tiles.select {|tile| tile.x == column_number}
      raise InvalidTilesError if column.length > 1
      
      column.first
    end
  end
end