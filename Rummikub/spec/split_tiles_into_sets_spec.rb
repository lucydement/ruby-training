require 'rails_helper' 

RSpec.describe SplitTilesIntoSets do
  context "When given one set" do
    it "returns one set" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 1
    end
  end

  context "When given two sets on different rows" do
    it "returns two sets" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0},
        {"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>1, "on_board"=>true, "x"=>4, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>nil, "on_board"=>true, "x"=>5, "y"=>3},
        {"id"=>115, "colour"=>"red", "number"=>13, "player_id"=>nil, "on_board"=>true, "x"=>6, "y"=>3}]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 2
    end
  end

  context "When given two sets on the same row" do
    it "returns two sets" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3},
        {"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>1, "on_board"=>true, "x"=>6, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>nil, "on_board"=>true, "x"=>7, "y"=>3},
        {"id"=>115, "colour"=>"red", "number"=>13, "player_id"=>nil, "on_board"=>true, "x"=>8, "y"=>3}]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call.length).to eql 2
    end
  end

  context "When given two tiles in the same place" do
    it "returns false" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>0, "y"=>1},
        {"id"=>158, "colour"=>"black", "number"=>7, "game_id"=>2, "player_id"=>nil, "on_board"=>true, "x"=>0, "y"=>1}]
      split_tiles = SplitTilesIntoSets.new(tiles)
      expect(split_tiles.call).to be_falsey
    end
  end
end