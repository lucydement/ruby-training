require 'rails_helper' 

RSpec.describe UpdateCurrentPlayer do
  fixtures :games

  it "updates the current player" do
    update_current_player = UpdateCurrentPlayer.new(games(:set_game))
    update_current_player.call
    expect(games(:set_game).current_player).to eql 1
  end

  it "cycles around from player 3 to player 0" do
    update_current_player = UpdateCurrentPlayer.new(games(:game1))
    update_current_player.call
    expect(games(:game1).current_player).to eql 0
  end
end