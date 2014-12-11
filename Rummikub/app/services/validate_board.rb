class ValidateBoard
  def initialize(tiles)
    @tiles = tiles
    @moved_tiles = @tiles.select {|tile| tile.y && tile.x}
  end

  def call  
    !(tile_not_moved_from_hand_to_board? || tiles_moved_from_board_to_hand?) && board_valid?
  end

  private

  #Use actual models

  def board_valid? 
    #actual_tiles = CreateTiles.new(@tiles).call

    sets = SplitTilesIntoSets.new(@tiles).call
    return false if !sets

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
    return false if colours.length < group.length

    true
  end

  def tiles_moved_from_board_to_hand?
    moved_tiles_not_on_board = @moved_tiles.select {|tile| tile.x >= Game::BOARD_WIDTH || tile.y >= Game::BOARD_HEIGHT}
    board_tiles_in_hand = moved_tiles_not_on_board.select {|tile| tile.player_id == nil}
    return true if board_tiles_in_hand.length != 0
    false
  end

  def tile_not_moved_from_hand_to_board?
    players_tiles_on_board = @moved_tiles.select {|tile| tile.x < Game::BOARD_WIDTH && tile.y < Game::BOARD_HEIGHT && tile.player_id != nil}
    
    return true if players_tiles_on_board.length == 0
    false
  end

  def first_two_tiles_are_the_same_colour?(set)
    set[0].colour == set[1].colour
  end
end