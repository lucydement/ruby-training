class DrawTile
  def initialize(player:, game:)
    @player = player
    @game = game
  end

  def call
    new_tile = @game.bag.sample
    new_tile.update_attributes(player_id: @player.id)
  end
end