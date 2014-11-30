require 'rails_helper'

RSpec.describe MoveTile do
  fixtures :games, :tile_sets, :tiles

  context "When inserting a new tile" do    
    it "will insert a tile at the beginning of the set" do
      move = MoveTile.new(tile: tiles(:new_tile), to: tile_sets(:set_valid_run), position: 0)
      move.call
      expect(tile_sets(:set_valid_run).tiles.length).to eql 4
    end
  end
end