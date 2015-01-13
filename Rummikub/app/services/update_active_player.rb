class UpdateActivePlayer
  def initialize(game)
    @game = game
  end

  def call #put in two lines
    @game.update_attributes!(active_player_number: (@game.active_player_number + 1) % @game.total_player_count)
  end
end