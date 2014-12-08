class UpdateGame
  def initialize(game, game_tiles, player)
    @game = game
    @changed_tiles = game_tiles.select {|tile| tile["x"] != nil && tile["y"] != nil}
    @player = player
  end

  def call
    if @game.bag.empty?
      @player.update_attributes!(passed: false)
    end

    board_tiles = @changed_tiles.select {|tile| tile["x"] < 16 && tile["y"] < 8}
    update_board(board_tiles)

    hand = @changed_tiles.select {|tile| tile["x"] > 15 && tile["y"] > 7}
    update_hand(hand)
  end

  private

  def update_board(board)
    board.each do |tile_data|
      id = tile_data["id"]
      tile = @game.tiles.detect {|tile| tile.id == id}
      tile.update_attributes!(player_id: nil, x: tile_data["x"], y: tile_data["y"], on_board: true)
    end
  end

  def update_hand(hand)
    hand.each do |tile_data|
      id = tile_data["id"]
      tile = @game.tiles.detect {|tile| tile.id == id}
      tile.update_attributes!(x: nil, y: nil)
    end
  end
end