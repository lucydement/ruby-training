class ValidateBoard
  def initialize(tiles)
    @tiles = tiles
  end

  def call  
    return false if tile_not_moved_from_hand_to_board?
    return false if board_invalid?
    return false if tiles_moved_from_board_to_hand?
    true
  end

  private

  def board_invalid?
    sets = SplitTilesIntoSets.new(@tiles).call
    return true if !sets

    sets.detect {|set| set_invalid?(set)}
  end

  def set_invalid?(set)
    return true if set.length < 3

    if set[0]["colour"] == set[1]["colour"]
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
    moved_tiles = @tiles.select {|tile| tile["y"] != nil && tile["x"] != nil}
    moved_tiles_not_on_board = moved_tiles.select {|tile| tile["x"] > 15 || tile["y"] > 7}
    board_tiles = moved_tiles_not_on_board.select {|tile| tile["player_id"] == nil}
    return true if board_tiles.length != 0
    false
  end

  def tile_not_moved_from_hand_to_board?
    moved_tiles = @tiles.select {|tile| tile["y"] != nil && tile["x"] != nil}
    players_tiles_on_board = moved_tiles.select {|tile| tile["x"] < 16 && tile["y"] < 8 && tile["player_id"] != nil}
    return true if players_tiles_on_board.length == 0
    false
  end
end