class GamesController < ApplicationController
  def create
    game = Game.create!
    game.setup
    redirect_to game
  end

  def show
    @game = Game.find params[:id]
    @player = @game.players.first
  end
end
