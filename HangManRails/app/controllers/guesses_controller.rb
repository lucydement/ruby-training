class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    if game.won? || game.lost?
      raise("Cannot enter letters after game has ended.")
    end

    guess = game.guesses.create(params.require(:guess).permit(:letter))

    redirect_to game
  end
end
