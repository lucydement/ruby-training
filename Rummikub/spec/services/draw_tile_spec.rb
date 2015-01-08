require 'rails_helper'

RSpec.describe DrawTile do
  fixtures :games, :players, :tiles

  context "When drawing a tile" do
    let(:draw_tile) {DrawTile.new(games(:set_game))}
    
    it "will add the tile to the players hand" do
      draw_tile.call
      expect(players(:player1).tiles.length).to eql 1
    end

    it "the tile will not be on the board" do
      draw_tile.call
      expect(tiles(:bagTile).on_board).to be_falsey
      expect(tiles(:bagTile).x).to be_falsey
      expect(tiles(:bagTile).y).to be_falsey
    end
  end

  context "When bag is empty" do
    let(:draw_tile) {DrawTile.new(games(:game2))}

    it "will not draw a tile" do
      draw_tile.call
      expect(players(:player4).tiles.length).to eql 1
    end

    it "will mark the player as passed" do
      draw_tile.call
      expect(players(:player4).passed).to be_truthy
    end
  end
end