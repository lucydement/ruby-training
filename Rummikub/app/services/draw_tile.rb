class DrawTile
  def initialize(player:, game:)
    @player = player
    @game = game
  end

  def call
    if @game.bag.empty?
      @player.update_attributes!(passed: true)
    else
      new_tile = @game.bag.sample
      new_tile.update_attributes!(player: @player)
    end
  end
end