require 'rails_helper'

RSpec.describe Player, :type => :model do
  fixtures :players, :users
  let(:player) {Player.create!(game_id: 1, number: 0, user_id: 1)}

  context "When creating a player" do
    it "should create a player" do
      expect(Player.new(game_id: 1, number: 0, user_id: 1).save).to be_truthy
    end

    it "should fail when no game_id is specified" do
      expect(Player.new(number: 0, user_id: 2).save).to be_falsey
    end

    it "should fail when no number is specified" do
      expect(Player.new(game_id: 0, user_id: 1).save).to be_falsey
    end

    it "should fail when no user_id is specified" do
      expect(Player.new(number: 1, game_id: 0).save).to be_falsey
    end

    it "should have no tiles" do
      expect(player.tiles.empty?).to be_truthy
    end
  end
end