class UpdateGame
  def initialize(game, game_tiles)
    @game = game
    @changed_tiles = game_tiles.select {|tile| tile["x"] != nil && tile["y"] != nil}
  end

  def call
    board_tiles = @changed_tiles.select {|tile| tile["x"] < 16 && tile["y"] < 8}
    board_tiles.each do |tile_data|
      id = tile_data["id"]
      tile = @game.tiles.find(id: id)
      tile.updateAttributes(player_id: nil, x: tile_data["x"], y: tile_data["y"])
    end
  end
end