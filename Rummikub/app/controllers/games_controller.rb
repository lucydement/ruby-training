class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    game = Game.create!
    SetupGame.new(game).call
    redirect_to game
  end

  def show
    @game = Game.find params[:id]
    current_player = GetCurrentPlayer.new(@game).call

    if request.xhr?
      render json: TileDecorator.new(@game, current_player).call
    end
    # respond_to?
  end

  def update
    game = Game.find params[:id]
    player = GetCurrentPlayer.new(game).call

    if request.xhr? && !game.ended?
      game_tiles = params[:tiles]

      if !SubmitMove.new(game, player, game_tiles).call
        flash[:invalid] = "That move was invalid."
      end
    end

    render nothing: true
  end
end
