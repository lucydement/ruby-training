class GamesController < ApplicationController
  def create
    game = Game.create!
    game.setup
    redirect_to game
  end

  def show
    @game = Game.find params[:id]
    current_player = @game.current_player
    @player = @game.players.where(number: current_player).first
    if request.xhr?
      render json: TileDecorator.new(@game, @player).call
    end
  end

  def update
    game = Game.find params[:id]
    if request.xhr? && !game.won?
      player = game.players.where(number: game.current_player).first
      game_tiles = params[:tiles]
      draw_tile = params[:drawTile]
      puts draw_tile
      puts "nil" if game_tiles == nil

      if draw_tile == "drawTile"
        puts "Draw"
        DrawTile.new(player: player ,game: game).call
        game.update_attributes(current_player: (game.current_player + 1) % 4)
      elsif ValidateBoard.new(game_tiles).call
        UpdateGame.new(game, game_tiles).call
        game.update_attributes(current_player: (game.current_player + 1) % 4)
      else
        #flash invalid and go to show again.
        puts "invalid"
        flash[:invalid] = "That move was invalid."
      end

      render nothing: true
    end
  end
end
