require 'rails_helper' 

RSpec.describe SplitTilesIntoSets do
  context "When given one set" do
    it "returns one set" do
      tiles = [
        instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 0),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 0)
      ]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 1
    end
  end

  #make a method that has defaults, set only x and y

  context "When given two sets on different rows" do
    it "returns two sets" do
      tiles = [
        instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 0),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 0),
        instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: 1, on_board: true, x: 4, y: 3),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: nil, on_board: true, x: 5, y: 3),
        instance_double('Tile', id: 115, colour: Tile::RED, number: 13, player_id: nil, on_board: true, x: 6, y: 3)
      ]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 2
    end
  end

  context "When given two sets on the same row" do
    it "returns two sets" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 3),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 3),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 3),
        instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: 1, on_board: true, x: 6, y: 3),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: nil, on_board: true, x: 7, y: 3),
        instance_double('Tile', id: 115, colour: Tile::RED, number: 13, player_id: nil, on_board: true, x: 8, y: 3)]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 2
    end
  end

  context "When given two tiles in the same place" do
    it "raises an error" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: nil, on_board: true, x: 0, y: 1),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 7, game_id: 2, player_id: nil, on_board: true, x: 0, y: 1)]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect{ split_tiles.call }.to raise_error(SplitTilesIntoSets::InvalidTilesError)
    end
  end
end