module GamesHelper
  def heading(game)
    if game.not_enough_users?
      "Join Game!" 
    elsif game.won?
      "The game was won by player #{game.winning_player.number + 1}."
    elsif game.ended?
      "The game is over because the bag is empty."
    else
      "Player #{game.current_player + 1}'s turn."
    end
  end
end
