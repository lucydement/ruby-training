require 'rails_helper'

RSpec.describe SetupGame do
  let(:setup_game) {SetupGame.new(4)}
  let(:game) {setup_game.call}

  it "Creates 104 tiles" do
    expect(game.tiles.length).to eql 104
  end

  it "Creates two red threes" do
    expect(game.tiles.where(number: 3, colour: Tile::RED).length).to eql 2
  end

  it "will make the current player 0" do
    expect(game.current_player_number).to eql 0
  end
end