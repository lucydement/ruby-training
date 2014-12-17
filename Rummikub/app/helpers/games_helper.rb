module GamesHelper
  def heading(game, current_user)
    if game.not_enough_users?
      "Waiting for Players" 
    elsif game.won?
      "The game was won by #{game.winning_player.users.first.name}"
    elsif game.ended?
      "The game is over because the bag is empty"
    elsif current_user == game.user_whose_turn_it_is
      "Your turn."
    else
      "#{game.user_whose_turn_it_is.name}'s Turn"
    end
  end
end
