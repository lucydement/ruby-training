require 'rails_helper'

RSpec.describe UpdateGame do
  fixtures :games, :players, :tiles

  before do
    tiles = [{"id"=>tiles(:tile1).id, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>tiles(:tile2).id, "player_id"=>1, "on_board"=>nil, "x"=>3, "y"=>2},
        {"id"=>tiles(:tile3).id, "player_id"=>1, "on_board"=>nil, "x"=>nil, "y"=>nil},
        {"id"=>tiles(:tile4).id, "player_id"=>1, "on_board"=>nil, "x"=>16, "y"=>8}]
    game = games(:set_game)
    @update_game = UpdateGame.new(game, tiles, players(:player1))
  end

  context "When moving a tile around on the board" do
    it "will not be in a players hand" do
      @update_game.call
      expect(tiles(:tile1).reload.player_id).to be_nil
    end

    it "will be at position 2,3 on the board" do
      @update_game.call
      expect(tiles(:tile1).reload.x).to eql 2
      expect(tiles(:tile1).y).to eql 3
    end

    it "will be on the board" do
      @update_game.call
      expect(tiles(:tile1).reload.on_board).to be_truthy
    end
  end

  context "When moving a tile from players hand to the board" do
    it "will not be in players hand" do
      @update_game.call
      expect(tiles(:tile2).reload.player_id).to be_nil
    end

    it "will be at position 3,2 on the board" do
      @update_game.call
      expect(tiles(:tile2).reload.x).to eql 3
      expect(tiles(:tile2).y).to eql 2
    end

    it "will be on the board" do
      @update_game.call
      expect(tiles(:tile2).reload.on_board).to be_truthy
    end
  end

  context "When a tile in the players hand has not moved" do
    it "will be in the players hand" do
      @update_game.call
      expect(tiles(:tile3).reload.player_id).to be_truthy
    end

    it "will not be on the board" do
      @update_game.call
      expect(tiles(:tile3).reload.on_board).to be_nil
    end

    it "will have no x,y coordinates" do
      @update_game.call
      expect(tiles(:tile3).reload.x).to be_nil
      expect(tiles(:tile3).y).to be_nil
    end
  end

  context "When a tile has been moved but is not on the board" do
    it "will be in the players hand" do
      @update_game.call
      expect(tiles(:tile4).reload.player_id).to be_truthy
    end

    it "will not be on the board" do 
      @update_game.call
      expect(tiles(:tile4).reload.on_board).to be_nil
    end

    it "will have no x,y coordinates" do
      @update_game.call
      expect(tiles(:tile4).reload.x).to be_nil
      expect(tiles(:tile4).y).to be_nil
    end
  end

  context "When the bag is empty" do
    it "will set the players passed to false" do
      tiles = [{"id"=>tiles(:tile5).id, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3}]
      game = games(:game2)
      update_game = UpdateGame.new(game,tiles,players(:player4))
      update_game.call
      expect(players(:player4).reload.passed).to be_falsey
    end
  end
end