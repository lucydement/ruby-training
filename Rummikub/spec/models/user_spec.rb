require 'rails_helper'

RSpec.describe User, :type => :model do
  fixtures :games, :users, :players

  it "can find the player for a specific game" do
    expect(users(:user_1).player_for_game(games(:set_game))).to eql players(:player1)
  end

  it "knows if it doesn't belong to a game" do
    expect(users(:user_1).not_in_game?(games(:game1))).to eql true
  end

  it "knows if it belongs to a game" do
    expect(users(:user_1).not_in_game?(games(:set_game))).to eql false
  end
end
