class ValidateBoard   #move policy
  def initialize(tiles)
    @tiles = tiles
    @board_tiles = @tiles.select(&:on_board)
  end

  def call
    tile_moved_from_hand_to_board? && !tiles_moved_from_board_to_hand? && board_valid?
  end

  private

  def board_valid? 
    sets = SplitTilesIntoSets.new(@board_tiles).call

    sets.all? {|set| set_valid?(set)}  #create tile_set object in splittiles...
  end

  def set_valid?(set) #call it what it is
    set.length >= 3 && (run_valid?(set) || group_valid?(set))
  end

  def run_valid?(run)
    colours = run.map(&:colour).uniq
    
    return false if colours.length != 1

    ordered_tiles = run.sort_by(&:x)
    numbers = ordered_tiles.map(&:number)

    #(1...numbers.length).all? {|i| numbers[i] - numbers[i - 1] == 1}
    numbers.each_cons(2).all? {|first, second| second - first == 1}
    #numbers == (numbers.first..numbers.first+numbers.length).to_a
  end

  def group_valid?(group)
    numbers = group.map(&:number).uniq

    return false if numbers.length != 1

    colours = group.map(&:colour).uniq  #will extract to method
    
    colours.length == group.length
  end

  def tiles_moved_from_board_to_hand?
    @tiles.any? {|tile| !tile.on_board && tile.on_board_was} 
  end

  def tile_moved_from_hand_to_board?
    players_tiles_on_board = @board_tiles.select {|tile| tile.player_id_was}
    
    players_tiles_on_board.present?  #ditto
  end
end