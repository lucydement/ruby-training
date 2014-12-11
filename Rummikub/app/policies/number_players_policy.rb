class NumberPlayersPolicy
  POSSIBLE = (2..7)

  def initialize(number_players)
    @number_players = number_players
  end

  def call
    (@number_players.is_a? Integer) && POSSIBLE.include?(@number_players)
  end
end