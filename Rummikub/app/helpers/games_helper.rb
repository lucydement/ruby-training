module GamesHelper
  def heading(game, current_user) 
    if game.not_enough_players? && game.won?
      "The game is over"
    elsif game.not_enough_players?
      "Waiting for Players"
    elsif game.won?
      "The game was won by #{game.winning_player.user.name}"
    elsif game.ended?
      "The game is over because the bag is empty"
    elsif current_user == user_whose_turn_it_is(game)
      "Your turn."
    else
      "#{user_whose_turn_it_is(game).name}'s Turn"
    end
  end

  def user_whose_turn_it_is(game)
    playing_player = game.players.find {|player| player.number == game.active_player_number}
    if playing_player
      playing_player.user
    end
  end
end
