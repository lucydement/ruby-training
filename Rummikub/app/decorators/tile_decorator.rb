class TileDecorator
  def initialize(game, player)
    @game = game
    @player = player
  end

  def call
    selected_tiles = @game.tiles.where("on_board IS NOT NULL OR player_id=?",@player.id)
    {tiles: selected_tiles}.to_json
  end
end