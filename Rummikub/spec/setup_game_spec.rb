require 'rails_helper'

RSpec.describe SetupGame do
  let(:game) {Game.create!}
  let(:setup_game) {SetupGame.new(game)}

  it "Creates 104 tiles" do
    setup_game.call

    expect(game.tiles.length).to eql 104
  end

  it "Creates two red threes" do
    setup_game.call

    expect(game.tiles.where(number: 3, colour: Tile::RED).length).to eql 2
  end

  it "Creates 4 players" do
    setup_game.call

    expect(game.players.length).to eql Game::NUMBER_PLAYERS
  end

  it "makes each player has 14 tiles" do
    setup_game.call

    expect(game.players[0].tiles.length).to eql Player::HAND_SIZE
  end

  it "will make the current player 0" do
    setup_game.call

    expect(game.current_player).to eql 0
  end
end