module GamesHelper
  def heading(game) 
    if game.won?
      return "The game was won by player #{game.won? + 1}."
    else
      return "Player #{game.current_player + 1}'s turn."
    end
  end
end
