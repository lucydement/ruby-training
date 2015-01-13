require_relative '../delegators/games_delegator'

class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    number_players = params.require(:game).permit(:total_player_count)["total_player_count"].to_i
    
    if NumberPlayersPolicy.new(number_players).call
      game = SetupGame.new(number_players).call
      MakePlayer.new(game, current_user).call
      redirect_to game
    else  #alert
      flash[:wrong_number_players] = "You cannot have this amount of players."
      redirect_to games_path, alert: "string"
    end
  end

  def show  #make decorator/presentor
    @game = GamesDelegator.new(Game.find(params[:id]))
    @players = @game.players

    if request.xhr?  #respond to
      render json: @game.tiles.not_in_bag  #add active_player_number in here
    end
  end

  def update
    game = Game.find(params[:id])

    if request.xhr? && !game.ended?
      game_tiles = params[:tiles]
      draw_tile = params[:drawTile]

      unless SubmitMove.new(game, game_tiles, draw_tile).call
        flash[:invalid] = "That move was invalid."
      end
    end

    render nothing: true
  end

  def active_player_number
    game = Game.find params[:game_id]
    if game && game.begun?
      render text: game.active_player_number
    else
      render nothing: true
    end
  end
end