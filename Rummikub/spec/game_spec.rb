require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) {Game.create}

  context "When creating a game" do
    it "will create a game" do
      expect(Game.create).to be_truthy
    end

    it "will have 4 players" do
      game.setup
      expect(game.players.length).to eql 4
    end
  end

  context "Test method setup" do
    
  end
end