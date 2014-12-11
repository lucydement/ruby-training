require 'rails_helper'

RSpec.describe Game, :type => :model do
  fixtures :games, :tiles, :players

  let(:game) {Game.create(number_players: 4)}

  context "When creating a game" do
    it "will create a game" do
      expect(Game.create(number_players: 4)).to be_truthy
    end
  end

  it "knows when a game is won" do
    expect(games(:set_game).won?).to be_truthy
  end

  it "knows who has won the game" do
    expect(games(:set_game).winning_player).to eql players(:player1)
  end

  it "knows when a game is not won" do
    expect(games(:game5).won?).to be_falsey
  end

  it "returns nil when no one has won" do
    expect(games(:game5).winning_player).to be_nil
  end

  context "test when the game ended" do
    it "will return true when someone has won" do
      expect(games(:set_game).ended?).to be_truthy
    end

    it "will return true when the bag is empty and all players have passed" do
      expect(games(:game3).ended?).to be_truthy
    end

    it "will return false when the bag is empty and one player has yet to pass" do
      expect(games(:game4).ended?).to be_falsey
    end

    it "will return false if the bag isn't empty and no one has won" do
      expect(games(:game5).ended?).to be_falsey
    end
  end
end