class PlayersController < ApplicationController
  def create
    @game = Game.find params[:game_id]
    
    if @game.not_enough_users?
      player = @game.get_free_player
      current_user.update_attributes!(player_id: player.id)
    end

    redirect_to @game
  end
end
