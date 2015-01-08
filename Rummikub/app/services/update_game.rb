class UpdateGame
  def initialize(tiles, game)
    @tiles = tiles
    @game = game
  end

  def call
    if @game.bag.empty?
      @game.active_player.update_attributes!(passed: false)
    end

    @tiles.each {|tile| tile.save}
  end
end
