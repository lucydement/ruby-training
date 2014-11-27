require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) {Game.create}

  context "When creating a game" do
    it "will create a game" do
      expect(Game.create).to be_truthy
    end
  end

  context "Test method setup" do
    it "will add 4 players" do
      game.setup
      expect(game.players.length).to eql 4
    end

    it "will create 104 tiles" do
      game.setup
      expect(game.tiles.length). to eql 104
    end

    it "will contain 2 red threes" do
      game.setup
      expect(game.tiles.where(number: 3, colour: "red").length).to eql 2
    end
  end
end