module GamesHelper
  def display_number_of_tiles_in_hands(game, players)
    if !game.not_enough_players?
      string = "<p>Number of tiles in hand:</p><ul>"
      players.each do |player|
        string << "<li>#{player.user.name}: #{player.tiles.length}</li>"
      end
      string << "</us>"
      string.html_safe
    end
  end

  def display_buttons(game, current_user)
    if game.active_player.user == current_user && game.begun?
      "<button id=\"submit\">Submit Move</button>
       <button id=\"drawTile\">Draw Tile</button>
       <button id=\"reset\">Reset Move</button>".html_safe
    end
  end
end
