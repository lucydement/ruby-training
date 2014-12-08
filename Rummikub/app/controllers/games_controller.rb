class GamesController < ApplicationController
  def create
    game = Game.create!
    game.setup
    redirect_to game
  end

  def show
    @game = Game.find params[:id]
    current_player = GetCurrentPlayer.new(@game).call

    if request.xhr?
      render json: TileDecorator.new(@game, current_player).call
    end
  end

  def update
    game = Game.find params[:id]
    player = GetCurrentPlayer.new(game).call

    if request.xhr? && !game.ended?
      game_tiles = params[:tiles]

      SubmitMove.new(game, player, game_tiles).call

      render nothing: true
    end
  end
end
