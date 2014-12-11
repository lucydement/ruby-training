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

  it "Creates 4 players" do
    expect(game.players.length).to eql 4
  end

  it "makes each player has 14 tiles" do
    expect(game.players[0].tiles.length).to eql Player::HAND_SIZE
  end

  it "will make the current player 0" do
    expect(game.current_player).to eql 0
  end
end