require 'rails_helper'

RSpec.describe GetCurrentPlayer do
  fixtures :games, :players

  it "returns the current player" do
    get_player = GetCurrentPlayer.new(games(:game1))
    expect(get_player.call).to eql(players(:player3))
  end
end