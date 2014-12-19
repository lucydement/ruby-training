class GetActivePlayer
  def initialize(game)
    @game = game
  end

  def call
    active_player_number = @game.active_player_number
    @game.players.where(number: active_player_number).first
  end
end