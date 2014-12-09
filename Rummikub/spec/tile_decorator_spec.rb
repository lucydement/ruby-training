require 'rails_helper'

RSpec.describe TileDecorator do
  fixtures :games, :players, :tiles

  context "When an empty board" do
    it "will return nothing if there is a tile with on_board = nil" do
      tile_decorator = TileDecorator.new(games(:decorator_game1), players(:decorator_player1))
      
      expect(tile_decorator.call).to eql "{\"tiles\":[]}"
    end

    it "will return nothing if there is a tile with on_board = false" do
      tile_decorator = TileDecorator.new(games(:decorator_game2), players(:decorator_player2))
      
      expect(tile_decorator.call).to eql "{\"tiles\":[]}"
    end
  end

  context "When the board isn't empty" do
    it "will return the tile on the board" do
    tile_decorator = TileDecorator.new(games(:decorator_game5), players(:decorator_player5))

    json = JSON.parse(tile_decorator.call)

    expect(json["tiles"].length).to eql 1
    expect(json["tiles"][0]["colour"]).to eql Tile::YELLOW
    expect(json["tiles"][0]["number"]).to eql 12
    end
  end

  it "will return nothing if there is a tile in a different players hand" do
    tile_decorator = TileDecorator.new(games(:decorator_game3), players(:decorator_player3and1))

    expect(tile_decorator.call).to eql "{\"tiles\":[]}"
  end

  it "will return one tile if there is a tile in the players hand" do
    tile_decorator = TileDecorator.new(games(:decorator_game4), players(:decorator_player4))

    json = JSON.parse(tile_decorator.call)

    expect(json["tiles"].length).to eql 1
    expect(json["tiles"][0]["colour"]).to eql Tile::BLACK
    expect(json["tiles"][0]["number"]).to eql 6
  end
end