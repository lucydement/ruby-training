class GamesController < ApplicationController
  def create
    game = Game.create!
    game.setup
    redirect_to game
  end

  def show
    @game = Game.find params[:id]
    @player = @game.players.first
    if request.xhr?
      render json: TileDecorator.new(@game, @player).call
    end
  end

  def update
    if request.xhr?
      game_tiles = params[:tiles]
      puts
      puts game_tiles
      if ValidateBoard.new(game_tiles).call
        puts "Update game!"
        #Update game
      else
        puts "Invalid"
        #flash invalid and go to show again.
      end

      puts "RECEIVED A PUT REQUEST!"
      render nothing: true
    end
  end
end
