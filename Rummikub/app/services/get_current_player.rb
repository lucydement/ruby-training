class GetCurrentPlayer
  def initialize(game)
    @game = game
  end

  def call
    current_player_number = @game.current_player_number
    @game.players.where(number: current_player_number).first
  end
end