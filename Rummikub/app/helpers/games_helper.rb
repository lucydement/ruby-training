module GamesHelper
  def heading(game) 
    if game.won?
      return "The game was won by player #{game.won? + 1}."
    elsif game.ended?
      return "The game is over because the bag is empty."
    else
      return "Player #{game.current_player + 1}'s turn."
    end
  end
end
