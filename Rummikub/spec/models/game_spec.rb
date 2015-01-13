require 'rails_helper'

RSpec.describe Game, :type => :model do
  fixtures :games, :tiles, :players, :users

  #wrap in describe block
  it "knows when there aren't enough players" do
    expect(games(:set_game).not_enough_players?).to be_truthy
  end

  it "knows when there are enough players" do
    expect(games(:full_game).not_enough_players?).to be_falsey
  end

  it "knows when the game has begun" do
    expect(games(:full_game).begun?).to be_truthy
  end

  it "knows when the game hasn't started yet" do
    expect(games(:set_game).begun?).to be_falsey
  end

  it "knows when a game is won" do
    expect(games(:set_game).won?).to be_truthy
    expect(games(:set_game)).to be_won
  end

  it "knows who has won the game" do
    expect(games(:set_game).winning_player).to eq players(:player1)
  end

  it "knows when a game is not won" do
    expect(games(:game5).won?).to be_falsey
  end

  it "returns nil when no one has won" do
    expect(games(:game5).winning_player).to be nil
  end

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

  it "will return the current active player" do
    expect(games(:game2).active_player).to eql players(:player4)
  end
end