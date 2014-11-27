require 'rails_helper'

RSpec.describe TileSet, :type => :model do
  fixtures :games, :tile_sets, :tiles

  context "When creating a tile set" do
    it "should create a tile set" do
      expect(TileSet.new(game_id: 1).save).to be_truthy
    end

    it "should not create a tile set if the game_id is not specified" do
      expect(TileSet.new.save).to be_falsey
    end
  end

  context "When testing validity" do
    it "is valid when a valid group" do
      expect(tile_sets(:set_valid_group).valid_set?).to be_truthy
    end

    it "is a valid run" do
      expect(tile_sets(:set_valid_run).valid_set?).to be_truthy
    end

    it "is too small to be valid" do
      expect(tile_sets(:set_too_small).valid_set?).to be_falsey
    end
  end
end