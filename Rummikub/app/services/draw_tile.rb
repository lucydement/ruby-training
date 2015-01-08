class DrawTile
  def initialize(game)
    @game = game
  end

  def call
    if @game.bag.empty?
      @game.active_player.update_attributes!(passed: true)
    else
      new_tile = @game.bag.sample
      new_tile.update_attributes!(player: @game.active_player)
    end
  end
end