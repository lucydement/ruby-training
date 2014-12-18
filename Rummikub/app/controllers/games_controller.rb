class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    number_players = params.require(:game).permit(:total_number_players)["total_number_players"].to_i
    
    if NumberPlayersPolicy.new(number_players).call
      game = SetupGame.new(number_players).call
      redirect_to game
    else
      flash[:wrong_number_players] = "You cannot have this amount of players."
      redirect_to games_path
    end
  end

  def show
    @game = Game.find params[:id]
    @players = @game.players
    @current_player = GetCurrentPlayer.new(@game).call

    if request.xhr?
      render json: TileDecorator.new(@game, @current_player).call
    end
  end

  def update
    game = Game.find params[:id]

    #try regular post

    if request.xhr? && !game.ended?
      game_tiles = params[:tiles]

      unless SubmitMove.new(game, game_tiles).call
        flash[:invalid] = "That move was invalid."
      end
    end

    render nothing: true
  end

  def current_player_number
    game = Game.find params[:game_id]
    if game 
      player = GetCurrentPlayer.new(game).call
      render text: player.number
    end
  end
end