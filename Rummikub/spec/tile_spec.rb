require 'rails_helper'

RSpec.describe Tile, :type => :model do
  context "when creating a tile" do
    it "should create a tile" do
      expect(Tile.new(colour: Tile::RED ,number: 12, game_id: 2).save).to be_truthy
    end

    it "will not create a tile if both a on_board and player_id are truthy" do
      expect(Tile.new(colour: Tile::RED ,number: 12, game_id: 2, on_board: true, player_id: 3, x: 1, y: 1).save).to be_falsey
    end

    it "will create a tile when only one of on_board and player_id is truthy" do
      expect(Tile.new(colour: Tile::RED ,number: 12, game_id: 2, player_id: 1).save).to be_truthy
      expect(Tile.new(colour: Tile::RED ,number: 12, game_id: 2, on_board: true,x: 1, y: 1).save).to be_truthy
    end

    it "will not create a tile when a on_board is true but x and y are undifined" do
      expect(Tile.new(colour: Tile::RED, number: 3, game_id: 1, on_board: true).save).to be_falsey
    end

    it "will not create a tile when no colour" do
      expect(Tile.new(number: 2, game_id: 1).save).to be_falsey
    end

    it "will not create a tile when no number" do
      expect(Tile.new(colour: Tile::BLUE, game_id: 1).save).to be_falsey
    end

    it "will not create a tile when no game_id" do
      expect(Tile.new(number: 2, colour: Tile::BLACK).save).to be_falsey
    end

    it "will not create a tile if the number is out of range" do
      expect(Tile.new(colour: Tile::RED, number: 14, game_id: 1).save).to be_falsey
    end
  end
end