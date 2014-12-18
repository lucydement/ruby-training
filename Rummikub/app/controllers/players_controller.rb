class PlayersController < ApplicationController
  def create
    game = Game.find params[:game_id]

    if game.not_enough_players? && UserNotInGame.new(game, current_user).call
      MakePlayer.new(game, current_user).call
    end

    redirect_to game
  end
end