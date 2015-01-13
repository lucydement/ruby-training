class NumberPlayersPolicy
  POSSIBLE_PLAYERS = (2..7)

  def initialize(number_players)
    @number_players = number_players
  end

  def call # not in here in controller
    (@number_players.is_a? Integer) && POSSIBLE_PLAYERS.include?(@number_players)
  end
end