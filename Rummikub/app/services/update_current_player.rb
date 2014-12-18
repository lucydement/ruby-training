class UpdateCurrentPlayer
  def initialize(game)
    @game = game
  end

  def call
    @game.update_attributes!(current_player_number: (@game.current_player_number + 1) % @game.total_number_players)
  end
end