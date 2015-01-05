require 'rails_helper'

RSpec.describe CreateTiles do
  fixtures :games, :tiles
  context "When making one tile" do
    before do
      user_input = [{"id"=>tiles(:create_1).id.to_s, "colour"=>Tile::RED, "number"=>"1", "player_id"=>"1", "on_board"=>true, "x"=>"1", "y"=>"0"}]
      @create_tiles = CreateTiles.new(user_input, games(:create_game1))
      @create_tiles.call
    end

    it "makes one tile" do
      tile = tiles(:create_1).reload

      expect(tile.colour).to eql Tile::RED
      expect(tile.number).to eql 1
      expect(tile.player_id).to eql 1
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 1
      expect(tile.y).to eql 0
    end
  end

  context "When making two tiles" do
    before do
      user_input = [{"id"=>105, "colour"=>Tile::RED, "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>Tile::BLACK, "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0}]
      @create_tiles = CreateTiles.new(user_input)
    end

    it "makes the first tile" do
      tile = @create_tiles.call.first

      expect(tile.id).to eql 105
      expect(tile.colour).to eql Tile::RED
      expect(tile.number).to eql 1
      expect(tile.player_id).to eql 1
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 1
      expect(tile.y).to eql 0
    end

    it "makes the second tile" do
      tile = @create_tiles.call.last

      expect(tile.id).to eql 158
      expect(tile.colour).to eql Tile::BLACK
      expect(tile.number).to eql 1
      expect(tile.player_id).to eql nil
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 2
      expect(tile.y).to eql 0
    end
  end

  context "When making one valid set" do
    before do
      user_input = [{"id"=>105, "colour"=>Tile::RED, "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>Tile::BLACK, "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>159, "colour"=>Tile::BLUE, "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      @create_tiles = CreateTiles.new(user_input)
    end

    it "will make the first tile" do
      tile = @create_tiles.call.first

      expect(tile.id).to eql 105
      expect(tile.colour).to eql Tile::RED
      expect(tile.number).to eql 1
      expect(tile.player_id).to eql 1
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 1
      expect(tile.y).to eql 0
    end

    it "will make the second tile" do
      tile = @create_tiles.call[1]

      expect(tile.id).to eql 158
      expect(tile.colour).to eql Tile::BLACK
      expect(tile.number).to eql 1
      expect(tile.player_id).to be_nil
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 2
      expect(tile.y).to eql 0
    end

    it "will make the third tile" do
      tile = @create_tiles.call.last

      expect(tile.id).to eql 159
      expect(tile.colour).to eql Tile::BLUE
      expect(tile.number).to eql 1
      expect(tile.player_id).to eql nil
      expect(tile.on_board).to eql true
      expect(tile.x).to eql 3
      expect(tile.y).to eql 0
    end
  end
end