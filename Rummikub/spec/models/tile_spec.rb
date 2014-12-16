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

    it "will not create a tile if x is out of bounds" do
      expect(Tile.new(colour: Tile::RED, number: 2, game_id: 1, on_board: true, x: 16, y: 4).save).to be_falsey
    end

    it "will not create a tile if y is out of bounds" do
      expect(Tile.new(colour: Tile::RED, number: 2, game_id: 1, on_board: true, x: 3, y: 8).save).to be_falsey
    end
  end

  context "When calling x_y_on_board" do  
    it "knows when a tile is on the board" do
      tile = Tile.new(colour: Tile::RED, number: 3, x: 1, y: 1)

      expect(tile.x_y_on_board?).to be_truthy
    end

    it "knows when a tile has a too small y value" do
      tile = Tile.new(colour: Tile::RED, number: 3, x: 1, y: -1)

      expect(tile.x_y_on_board?).to be_falsey
    end

    it "knows when a tile has a too large y value" do
      tile = Tile.new(colour: Tile::RED, number: 3, x: 1, y: 16)

      expect(tile.x_y_on_board?).to be_falsey
    end

    it "knows when a tile has a too small x value" do
      tile = Tile.new(colour: Tile::RED, number: 3, x: -1, y: 1)

      expect(tile.x_y_on_board?).to be_falsey
    end

    it "knows when a tile has a too large x value" do
      tile = Tile.new(colour: Tile::RED, number: 3, x: 16, y: 1)

      expect(tile.x_y_on_board?).to be_falsey
    end

    it "returns false when x and y are nil" do
      tile = Tile.new(colour: Tile::BLACK, number: 6, x: nil, y: nil)

      expect(tile.x_y_on_board?).to be_falsey
    end
  end

  context "When calling in_hand" do
    it "knows when a tile is in a hand" do
      tile = Tile.new(colour: Tile::BLUE, number: 7, player_id: 3)

      expect(tile.in_hand?).to be_truthy
    end

    it "knows when a tile is not in a hand" do
      tile = Tile.new(colour: Tile::YELLOW, number: 13, player_id: nil)

      expect(tile.in_hand?).to be_falsey
    end
  end
end