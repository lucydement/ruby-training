class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    number_players = params.require(:game).permit(:number_players)["number_players"].to_i
    puts number_players
    puts NumberPlayersPolicy.new(number_players).call
    if NumberPlayersPolicy.new(number_players).call
      game = SetupGame.new(number_players).call
      redirect_to game
    else
      flash[:wrong_number_players] = "You cannot have this amount of players."
      render :new
    end
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
