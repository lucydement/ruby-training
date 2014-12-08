require 'rails_helper' 

RSpec.describe NextPlayer do
  fixtures :games

  it "updates the current player" do
    next_player = NextPlayer.new(games(:set_game))
    next_player.call
    expect(games(:set_game).current_player).to eql 1
  end

  it "cycles around from player 3 to player 0" do
    next_player = NextPlayer.new(games(:game1))
    next_player.call
    expect(games(:game1).current_player).to eql 0
  end
end