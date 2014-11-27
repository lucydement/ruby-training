require 'rails_helper'

RSpec.describe TileSet, :type => :model do
  context "When creating a tile set" do
    it "should create a tile set" do
      expect(TileSet.new(game_id: 1).save).to be_truthy
    end

    it "should not create a tile set if the game_id is not specified" do
      expect(TileSet.new.save).to be_falsey
    end
  end
end