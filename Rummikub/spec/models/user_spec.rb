require 'rails_helper'

RSpec.describe User, :type => :model do
  fixtures :games, :users, :players

  it "can find the player for a specific game" do
    expect(users(:user_1).player_for_game(games(:set_game))).to eql players(:player1)
  end
end
