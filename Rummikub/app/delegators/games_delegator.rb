class GamesDelegator < SimpleDelegator
  def heading(current_user)
    if not_enough_players?
      "Waiting for Players"
    elsif won?
      "The game was won by #{winning_player.user.name}"
    elsif ended?
      "The game is over because the bag is empty"
    elsif current_user == active_player.user
      "Your turn."
    else
      "#{active_player.user.name}'s Turn"
    end
  end
end