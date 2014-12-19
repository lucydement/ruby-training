require 'rails_helper' 

RSpec.describe UpdateActivePlayer do
  fixtures :games

  it "updates the current player" do
    update_active_player = UpdateActivePlayer.new(games(:set_game))
    update_active_player.call
    expect(games(:set_game).active_player_number).to eql 1
  end

  it "cycles around from player 3 to player 0" do
    update_active_player = UpdateActivePlayer.new(games(:game1))
    update_active_player.call
    expect(games(:game1).active_player_number).to eql 0
  end
end