class SplitTilesIntoSets
  def initialize(tiles)
    @tiles = tiles
  end

  def call
    @sets = []
    board = @tiles.select {|tile| tile["y"] != nil && tile["x"] != nil}

    (0..7).each do |i|
      row = board.select {|tile| tile["y"] == i}
      return false if !split_row_into_sets(row)
    end
    @sets
  end

  private

  def split_row_into_sets(row)
    set = []
    previous_was_nil = true

    (0..15).each do |i|
      column = row.select {|tile| tile["x"] == i}

      return false if column.length > 1

      if column.empty? && !previous_was_nil
        previous_was_nil = true
        @sets.push(set)
        set = []
      elsif !column.empty? 
        set.push(column[0])
        previous_was_nil = false
      end  
    end
  end
end