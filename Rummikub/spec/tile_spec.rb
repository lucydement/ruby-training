require 'rails_helper'

RSpec.describe Tile, :type => :model do
  context "when creating a tile" do
    it "should create a tile" do
      expect(Tile.new(colour: "red" ,number: 12, game_id: 2).save).to be_truthy
    end

    it "should not create a tile if both a tile_id and player_id are specified" do
      expect(Tile.new(colour: "red" ,number: 12, game_id: 2, tile_set_id: 1, player_id: 3, tile_set_order: 1, x: 1, y: 1).save).to be_falsey
    end

    it "should create a tile when only one is specified" do
      expect(Tile.new(colour: "red" ,number: 12, game_id: 2, player_id: 1).save).to be_truthy
      expect(Tile.new(colour: "red" ,number: 12, game_id: 2, tile_set_id: 1, tile_set_order: 0,x: 1, y: 1).save).to be_truthy
    end

    it "should not create a tile when a tile_set_id is specified but not a order" do
      expect(Tile.new(colour: "red", number: 3, game_id: 1, tile_set_id: 1).save).to be_falsey
    end

    it "shouldn't create a tile when no colour" do
      expect(Tile.new(number: 2, game_id: 1).save).to be_falsey
    end

    it "shouldn't create a tile when no number" do
      expect(Tile.new(colour: "blue", game_id: 1).save).to be_falsey
    end

    it "shouldn't create a tile when no game_id" do
      expect(Tile.new(number: 2, colour: "black").save).to be_falsey
    end

    it "shouldn't create a tile if the number is out of range" do
      expect(Tile.new(colour: "red", number: 14, game_id: 1).save).to be_falsey
    end
  end
end