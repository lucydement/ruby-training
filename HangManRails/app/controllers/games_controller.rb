class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find params[:id]
    @guesses = @game.guesses
  end

  def create
    game = Game.create!
    redirect_to game
  end
end
