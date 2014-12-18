require 'rails_helper'

RSpec.describe UserNotInGame do
  fixtures :games, :users

  it "knows when a user is in the game" do
    expect(UserNotInGame.new(games(:set_game), users(:user_1)).call).to be_falsey
  end

  it "knows when a user isn't in the game" do
    expect(UserNotInGame.new(games(:set_game), users(:user_2)).call).to be_truthy
  end
end