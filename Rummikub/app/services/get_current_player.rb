class GetCurrentPlayer
  def initialize(game)
    @game = game
  end

  def call
    current_player = @game.current_player
    @game.players.where(number: current_player).first
  end
end