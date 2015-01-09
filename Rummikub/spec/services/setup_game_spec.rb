require 'rails_helper'

RSpec.describe SetupGame do
  let(:setup_game) {SetupGame.new(4)}
  let(:game) {setup_game.call}

  it "creates a game" do
    expect {setup_game.call}.to change {Game.count}.by 1
  end

  it "Creates 104 tiles" do
    expect(game.tiles.length).to eql 104
  end

  it "Creates two red threes" do
    expect(game.tiles.where(number: 3, colour: Tile::RED).length).to eql 2
  end

  it "will make the current player 0" do
    expect(game.active_player_number).to eql 0
  end
end