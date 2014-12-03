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
      #render json: @game.tiles.where(player_id: @player.id).to_json
      render json: TileDecorator.new(@game, @player).call
    end
  end
end
