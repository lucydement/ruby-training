require 'rails_helper'

RSpec.describe GamesDelegator do
  fixtures :games, :users, :players

  context "Testing heading" do
    it "prints if not enough players" do
      games_delegator = GamesDelegator.new(games(:set_game))
      expect(games_delegator.heading(users(:user_1))).to eql "Waiting for Players"
    end

    it "prints if won" do
      games_delegator = GamesDelegator.new(games(:won_game))
      expect(games_delegator.heading(users(:won_user_1))).to eql "The game was won by Lucy"
    end

    it "prints if the bag is empty" do
      games_delegator = GamesDelegator.new(games(:game3))
      expect(games_delegator.heading(users(:won_user_1))).to eql "The game is over because the bag is empty"
    end

    it "prints out your turn if the current user is you" do
      games_delegator = GamesDelegator.new(games(:ongoing_game))
      expect(games_delegator.heading(users(:ongoing_user_1))).to eql "Your turn."
    end

    it "prints out the players turn" do
      games_delegator = GamesDelegator.new(games(:ongoing_game))
      expect(games_delegator.heading(users(:ongoing_user_2))).to eql "Lucy's Turn"
    end
  end
end