class TileDecorator
  def initialize(game, player)
    @game = game
    @player = player
  end

  def call
    selected_tiles = @game.tiles.where("tile_set_id IS NOT NULL OR player_id=?",@player.id)
    {tiles: selected_tiles}
  end
end