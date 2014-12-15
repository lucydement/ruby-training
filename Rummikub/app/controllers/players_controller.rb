class PlayersController < ApplicationController
  def create
    puts "CREATE PLAYER"

    @game = Game.find params[:game_id]
    player = @game.get_free_player
    current_user.update_attributes!(player_id: player.id)

    redirect_to @game
  end
end
