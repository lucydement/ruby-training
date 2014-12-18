class PlayersController < ApplicationController
  def create
    game = Game.find params[:game_id]

    MakePlayer.new(game, current_user).call

    redirect_to game
  end
end