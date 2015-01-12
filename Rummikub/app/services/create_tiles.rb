class CreateTiles
  def initialize(game_tiles, game)
    @game_tiles = game_tiles
    @game = game
  end

  def call
    return nil if !@game_tiles

    tiles = @game_tiles.map do |input|
      x = input["x"] ? input["x"].to_i : nil
      y = input["y"] ? input["y"].to_i : nil
      player_id = input["player_id"] ? input["player_id"].to_i : nil
      
      tile = @game.tiles.find(input["id"].to_i)
      tile.attributes = {player_id: player_id, on_board: input["on_board"], x: x, y: y}
      tile
    end
  end
end