module GamesHelper
  def heading(game)
    if game.not_enough_users?
      "Waiting for players." 
    elsif game.won?
      "The game was won by #{game.winning_player.users.first.name}."
    elsif game.ended?
      "The game is over because the bag is empty."
    else
      "#{game.user_whose_turn_it_is.name}'s turn."
    end
  end
end
