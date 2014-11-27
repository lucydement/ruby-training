class GamesController < ApplicationController
  def create
    game = Game.create!
    game.setup
  end
end
