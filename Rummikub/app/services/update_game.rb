class UpdateGame
  def initialize(game, game_tiles, player)
    @game = game
    @changed_tiles = game_tiles.select {|tile| tile["x"] && tile["y"]}
    @player = player
  end

  def call
    Game.transaction do
      if @game.bag.empty?
        @player.update_attributes!(passed: false)
      end

      board_tiles = find_board_tiles(@changed_tiles)
      update_board(board_tiles)
    end
  end

  private

  def update_board(board)
    board.each do |tile_data|
      id = tile_data["id"]
      tile = @game.tiles.detect {|tile| tile.id == id}
      tile.update_attributes!(player_id: nil, x: tile_data["x"], y: tile_data["y"], on_board: true)
    end
  end

  def find_board_tiles(tiles)
    tiles.select {|tile| tile["x"] < Game::BOARD_WIDTH && tile["y"] < Game::BOARD_HEIGHT}
  end
end
