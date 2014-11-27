class SetupGame
  def setup(game)
    (1..4).each {game.players.create!}
  end
end