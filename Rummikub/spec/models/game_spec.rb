require 'rails_helper'

RSpec.describe Game, :type => :model do
  fixtures :games, :tiles, :players, :users

  let(:game) {Game.create(number_players: 4)}

  context "When creating a game" do
    fixtures :games, :players, :users
    it "will create a game" do
      expect(Game.create(number_players: 4)).to be_truthy
    end

    it "will not have enough users" do
      set_up = SetupGame.new(4).call

      expect(set_up.not_enough_users?).to be_truthy
    end
  end

  context "Testing stuff with users" do
    it "knows when there aren't enough users" do
      expect(games(:set_game).not_enough_users?).to be_truthy
    end

    it "knows when there are enough users" do
      expect(games(:game1).not_enough_users?).to be_falsey
    end

    it "can get a free player" do
      expect(games(:set_game).get_free_player).to eql players(:player2)
    end

    it "returns nil if it can't get a free player" do
      expect(games(:game1).get_free_player).to be_nil
    end 

    it "knows if a user is already in a game" do
      expect(games(:set_game).user_not_in_game?(users(:user_1))).to be_falsey
    end

    it "knows if a user is not in the game" do
      expect(games(:set_game).user_not_in_game?(users(:user_2))).to be_truthy
    end

    it "can get the user who's turn it is" do
      expect(games(:game4).user_whose_turn_it_is).to eql users(:user_3)
    end

    it "can get the current users players id" do
      expect(games(:set_game).current_users_player_id(users(:user_1))).to eql players(:player1).id
    end

    it "will return nil if the current user isn't in the game" do
      expect(games(:set_game).current_users_player_id(users(:user_2))).to be_nil
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