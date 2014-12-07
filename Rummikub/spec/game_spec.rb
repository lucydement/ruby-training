require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) {Game.create}

  context "When creating a game" do
    it "will create a game" do
      expect(Game.create).to be_truthy
    end
  end

  context "Test method setup" do
    before do
      game.setup
    end

    it "will add 4 players" do
      expect(game.players.length).to eql 4
    end

    it "will create 104 tiles" do
      expect(game.tiles.length). to eql 104
    end

    it "will contain 2 red threes" do
      expect(game.tiles.where(number: 3, colour: "red").length).to eql 2
    end

    it "will have 48 tiles in the bag" do
      expect(game.bag.length).to eql 48
    end

    it "will mean a player has 14 tiles" do
      expect(game.players[0].tiles.length).to eql 14
    end
  end

  it "knows when a game is won" do
    expect(game.won?).to be_truthy
  end

  it "knows when a game is not won" do
    game.setup
    expect(game.won?).to be_falsey
  end
end