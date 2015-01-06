class UpdateGame
  def initialize(tiles, game, player)
    @tiles = tiles
    @game = game
    @player = player
  end

  def call
    if @game.bag.empty?
      @player.update_attributes!(passed: false)
    end

    @tiles.each {|tile| tile.save}
  end
end
