class NumberPlayersPolicy
  def initialize(number_players)
    @number_players = number_players
  end

  def call
    (@number_players.is_a? Integer) && (2..4).include?(@number_players)
  end
end