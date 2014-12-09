class ValidateBoard
  def initialize(tiles)
    @tiles = tiles
    @moved_tiles = @tiles.select {|tile| tile["y"] != nil && tile["x"] != nil}
  end

  def call  
    return false if tile_not_moved_from_hand_to_board?
    return false if board_invalid?
    return false if tiles_moved_from_board_to_hand?
    true
  end

  private

  def board_invalid?
    sets = SplitTilesIntoSets.new(@moved_tiles).call
    return true if !sets

    sets.detect {|set| set_invalid?(set)}
  end

  def set_invalid?(set)
    return true if set.length < 3

    if first_two_tiles_are_the_same_colour(set)
      return run_invalid?(set)
    else
      return group_invalid?(set)
    end
  end

  def run_invalid?(run)
    colours = run.map {|tile| tile["colour"]}.uniq
    
    return true if colours.length != 1

    ordered_tiles = run.sort_by {|tile| tile["x"]}
    numbers = ordered_tiles.map {|tile| tile["number"]}

    (1..numbers.length - 1).each do |i|
      return true if numbers[i] - numbers[i - 1] != 1
    end
    false
  end

  def group_invalid?(group)
    numbers = group.map {|tile| tile["number"]}.uniq
    return true if numbers.length != 1

    colours = group.map {|tile| tile["colour"]}.uniq
    return true if colours.length < group.length

    false
  end

  def tiles_moved_from_board_to_hand?
    moved_tiles_not_on_board = @moved_tiles.select {|tile| tile["x"] > Game::BOARD_WIDTH || tile["y"] > Game::BOARD_HEIGHT}
    board_tiles_in_hand = moved_tiles_not_on_board.select {|tile| tile["player_id"] == nil}
    return true if board_tiles_in_hand.length != 0
    false
  end

  def tile_not_moved_from_hand_to_board?
    players_tiles_on_board = @moved_tiles.select {|tile| tile["x"] <= Game::BOARD_WIDTH && tile["y"] <= Game::BOARD_HEIGHT && tile["player_id"] != nil}
    return true if players_tiles_on_board.length == 0
    false
  end

  def first_two_tiles_are_the_same_colour(set)
    set[0]["colour"] == set[1]["colour"]
  end
end