class ValidateBoard
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

    sets.all? {|set| set_valid?(set)}
  end

  def set_valid?(set)
    return false if set.length < 3

    if first_two_tiles_are_the_same_colour?(set)
      run_valid?(set)
    else
      group_valid?(set)
    end
  end

  def run_valid?(run)
    colours = run.map(&:colour).uniq
    
    return false if colours.length != 1

    ordered_tiles = run.sort_by(&:x)
    numbers = ordered_tiles.map(&:number)

    (1..numbers.length - 1).all? {|i| numbers[i] - numbers[i - 1] == 1}
  end

  def group_valid?(group)
    numbers = group.map(&:number).uniq

    return false if numbers.length != 1

    colours = group.map(&:colour).uniq
    
    colours.length == group.length
  end

  def tiles_moved_from_board_to_hand?
    board_tiles_in_hand = @tiles.select {|tile| !tile.on_board && tile.on_board_was}
    
    board_tiles_in_hand.present?
  end

  def tile_moved_from_hand_to_board?
    players_tiles_on_board = @board_tiles.select {|tile| tile.player_id_was}
    
    players_tiles_on_board.present?
  end

  def first_two_tiles_are_the_same_colour?(set)
    set[0].colour == set[1].colour
  end
end