require 'rails_helper'

RSpec.describe UpdateGame do
  fixtures :games, :players, :tiles

  before do
    new_tile_data = { 
      tiles(:tile1) => {player_id: nil, on_board: true, x: 2, y: 3},
      tiles(:tile2) => {player_id: nil, on_board: true, x: 3, y: 2},
      tiles(:tile3) => {player_id: 1, on_board: false, x: nil, y: nil},
      tiles(:tile4) => {player_id: 1, on_board: false, x: 16, y: 8}
    }

    new_tile_data.each do |tile, data|
      tile.attributes = data
    end

    game = games(:set_game)
    update_game = UpdateGame.new(new_tile_data.keys, game)
    update_game.call #in tests not before, as a let
  end

  context "When moving a tile around on the board" do
    it "will not be in a players hand" do
      expect(tiles(:tile1).reload.player_id).to be_nil
    end

    it "will be at position 2,3 on the board" do
      expect(tiles(:tile1).reload.x).to eql 2
      expect(tiles(:tile1).y).to eql 3
    end

    it "will be on the board" do
      expect(tiles(:tile1).reload.on_board).to be_truthy
    end
  end

  context "When moving a tile from players hand to the board" do
    it "will not be in players hand" do
      expect(tiles(:tile2).reload.player_id).to be_nil
    end

    it "will be at position 3,2 on the board" do
      expect(tiles(:tile2).reload.x).to eql 3
      expect(tiles(:tile2).y).to eql 2
    end

    it "will be on the board" do
      expect(tiles(:tile2).reload.on_board).to be_truthy
    end
  end

  context "When a tile in the players hand has not moved" do
    it "will be in the players hand" do
      expect(tiles(:tile3).reload.player_id).to be_truthy
    end

    it "will not be on the board" do
      expect(tiles(:tile3).reload.on_board).to be_falsey
    end

    it "will have no x,y coordinates" do
      expect(tiles(:tile3).reload.x).to be_nil
      expect(tiles(:tile3).y).to be_nil
    end
  end

  context "When a tile has been moved but is not on the board" do
    it "will be in the players hand" do
      expect(tiles(:tile4).reload.player_id).to be_truthy
    end

    it "will not be on the board" do 
      expect(tiles(:tile4).reload.on_board).to be_falsey
    end

    it "will have no x,y coordinates" do
      #reload here
      expect(tiles(:tile4).reload.x).to be_nil
      expect(tiles(:tile4).y).to be_nil
    end
  end

  context "When the bag is empty" do
    it "will set the players passed to false" do
      game = games(:game2)
      update_game = UpdateGame.new([tiles(:tile5)], game)
      update_game.call
      expect(players(:player4).reload.passed).to be_falsey
    end
  end
end