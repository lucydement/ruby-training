class NextPlayer
  def initialize(game)
    @game = game
  end

  def call
    @game.update_attributes(current_player: (@game.current_player + 1) % 4)
  end
end