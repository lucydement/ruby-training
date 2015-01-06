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

  def display_number_of_tiles_in_hands(game, players)
    if !game.not_enough_players?
      string = "Number of tiles in hand:<br /><br />"
      players.each do |player|
        string << "#{player.user.name}: #{player.tiles.length}<br />"
      end
      string.html_safe
    end
  end

  def display_buttons(game, current_user)
    if user_whose_turn_it_is(game) == current_user && game.begun?
      "<button id=\"submit\">Submit Move</button>
       <button id=\"drawTile\">Draw Tile</button>
       <button id=\"reset\">Reset Move</button>".html_safe
    end
  end

  def join_game_button(game, current_user)
    if game.not_enough_players? && UserNotInGame.new(game, current_user).call
      "<%= f.submit \"Join Game\" %>".html_safe
    end
  end
end
