class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    if game.won? || game.lost?
      flash[:notice] = "You cannot guess after you have won or lost."
    else
      guess = game.guesses.new(params.require(:guess).permit(:letter))
      if !guess.save
        flash[:notice] = "This is an invalid guess."
      end
    end
    
    redirect_to game
  end
end
