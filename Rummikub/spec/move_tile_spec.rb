require 'rails_helper'

RSpec.describe MoveTile do
  fixtures :games, :tile_sets, :tiles

  context "When inserting a new tile" do    
    context "when inserting a tile at the beginning of the set" do
      before do
        move = MoveTile.new(tile: tiles(:new_tile),from: nil, to: tile_sets(:set_valid_run), position: 0)
        move.call
        @ordered_tiles = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will have 4 elements" do
        expect(@ordered_tiles.length).to eql 4
      end

      it "will have a blue 4 in the first postion" do
        expect(@ordered_tiles[0].number).to eql 4
        expect(@ordered_tiles[0].colour).to eql "blue"
      end

      it "will have a blue 5 in the second position" do
        expect(@ordered_tiles[1].number).to eql 5
        expect(@ordered_tiles[1].colour).to eql "blue"
      end

      it "will have a blue 6 in the third position" do
        expect(@ordered_tiles[2].number).to eql 6
        expect(@ordered_tiles[2].colour).to eql "blue"
      end

      it "will have a blue 7 in the last position" do
        expect(@ordered_tiles[3].number).to eql 7
        expect(@ordered_tiles[3].colour).to eql "blue"
      end
    end

    context "when inserting in the middle of the set" do
      before do
        move = MoveTile.new(tile: tiles(:new_tile),from: nil, to: tile_sets(:set_valid_run), position: 1)
        move.call
        @ordered_tiles = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will have 4 elements" do
        expect(@ordered_tiles.length).to eql 4
      end

      it "will have a blue 5 in the first postion" do
        expect(@ordered_tiles[0].number).to eql 5
        expect(@ordered_tiles[0].colour).to eql "blue"
      end

      it "will have a blue 4 in the second position" do
        expect(@ordered_tiles[1].number).to eql 4
        expect(@ordered_tiles[1].colour).to eql "blue"
      end

      it "will have a blue 6 in the third position" do
        expect(@ordered_tiles[2].number).to eql 6
        expect(@ordered_tiles[2].colour).to eql "blue"
      end

      it "will have a blue 7 in the last position" do
        expect(@ordered_tiles[3].number).to eql 7
        expect(@ordered_tiles[3].colour).to eql "blue"
      end
    end

    context "when inserting at the end of the set" do
      before do
        move = MoveTile.new(tile: tiles(:new_tile),from: nil, to: tile_sets(:set_valid_run), position: 3)
        move.call
        @ordered_tiles = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will have 4 elements" do
        expect(@ordered_tiles.length).to eql 4
      end

      it "will have a blue 5 in the first postion" do
        expect(@ordered_tiles[0].number).to eql 5
        expect(@ordered_tiles[0].colour).to eql "blue"
      end

      it "will have a blue 6 in the second position" do
        expect(@ordered_tiles[1].number).to eql 6
        expect(@ordered_tiles[1].colour).to eql "blue"
      end

      it "will have a blue 7 in the third position" do
        expect(@ordered_tiles[2].number).to eql 7
        expect(@ordered_tiles[2].colour).to eql "blue"
      end

      it "will have a blue 4 in the last position" do
        expect(@ordered_tiles[3].number).to eql 4
        expect(@ordered_tiles[3].colour).to eql "blue"
      end
    end
  end

  context "when moving a tile within a set" do
    context "when moving from start to end" do
      before do
        move = MoveTile.new(tile: tiles(:tile8),from: tile_sets(:set_for_move), to: tile_sets(:set_for_move), position: 5)
        move.call
        @ordered_tiles = tile_sets(:set_for_move).tiles.order(:tile_set_order)
      end

      it "will have 5 elements" do
        expect(@ordered_tiles.length).to eql 5
      end

      it "will have a red 2 in the first position" do
        expect(@ordered_tiles[0].number).to eql 2
        expect(@ordered_tiles[0].colour).to eql "red"
      end

      it "will have a red 3 in the second position" do
        expect(@ordered_tiles[1].number).to eql 3
        expect(@ordered_tiles[1].colour).to eql "red"
      end

      it "will have a red 4 in the thrid position" do
        expect(@ordered_tiles[2].number).to eql 4
        expect(@ordered_tiles[2].colour).to eql "red"
      end

      it "will have a red 5 in the forth position" do
        expect(@ordered_tiles[3].number).to eql 5
        expect(@ordered_tiles[3].colour).to eql "red"
      end

      it "will have a red 1 in the last position" do
        expect(@ordered_tiles[4].number).to eql 1
        expect(@ordered_tiles[4].colour).to eql "red"
      end
    end

    context "when moving from end to start" do
      before do
        move = MoveTile.new(tile: tiles(:tile12),from: tile_sets(:set_for_move), to: tile_sets(:set_for_move), position: 0)
        move.call
        @ordered_tiles = tile_sets(:set_for_move).tiles.order(:tile_set_order)
      end

      it "will have 5 elements" do
        expect(@ordered_tiles.length).to eql 5
      end

      it "will have a red 5 in the first position" do
        expect(@ordered_tiles[0].number).to eql 5
        expect(@ordered_tiles[0].colour).to eql "red"
      end

      it "will have a red 1 in the second position" do
        expect(@ordered_tiles[1].number).to eql 1
        expect(@ordered_tiles[1].colour).to eql "red"
      end

      it "will have a red 2 in the thrid position" do
        expect(@ordered_tiles[2].number).to eql 2
        expect(@ordered_tiles[2].colour).to eql "red"
      end

      it "will have a red 3 in the forth position" do
        expect(@ordered_tiles[3].number).to eql 3
        expect(@ordered_tiles[3].colour).to eql "red"
      end

      it "will have a red 4 in the last position" do
        expect(@ordered_tiles[4].number).to eql 4
        expect(@ordered_tiles[4].colour).to eql "red"
      end
    end

    context "when moving forward" do
      before do
        move = MoveTile.new(tile: tiles(:tile9),from: tile_sets(:set_for_move), to: tile_sets(:set_for_move), position: 4)
        move.call
        @ordered_tiles = tile_sets(:set_for_move).tiles.order(:tile_set_order)
      end

      it "will have 5 elements" do
        expect(@ordered_tiles.length).to eql 5
      end

      it "will have a red 1 in the first position" do
        expect(@ordered_tiles[0].number).to eql 1
        expect(@ordered_tiles[0].colour).to eql "red"
      end

      it "will have a red 3 in the second position" do
        expect(@ordered_tiles[1].number).to eql 3
        expect(@ordered_tiles[1].colour).to eql "red"
      end

      it "will have a red 4 in the thrid position" do
        expect(@ordered_tiles[2].number).to eql 4
        expect(@ordered_tiles[2].colour).to eql "red"
      end

      it "will have a red 2 in the forth position" do
        expect(@ordered_tiles[3].number).to eql 2
        expect(@ordered_tiles[3].colour).to eql "red"
      end

      it "will have a red 5 in the last position" do
        expect(@ordered_tiles[4].number).to eql 5
        expect(@ordered_tiles[4].colour).to eql "red"
      end
    end

    context "when moving backwards" do
      before do
        move = MoveTile.new(tile: tiles(:tile11),from: tile_sets(:set_for_move), to: tile_sets(:set_for_move), position: 1)
        move.call
        @ordered_tiles = tile_sets(:set_for_move).tiles.order(:tile_set_order)
      end

      it "will have 5 elements" do
        expect(@ordered_tiles.length).to eql 5
      end

      it "will have a red 1 in the first position" do
        expect(@ordered_tiles[0].number).to eql 1
        expect(@ordered_tiles[0].colour).to eql "red"
      end

      it "will have a red 4 in the second position" do
        expect(@ordered_tiles[1].number).to eql 4
        expect(@ordered_tiles[1].colour).to eql "red"
      end

      it "will have a red 2 in the thrid position" do
        expect(@ordered_tiles[2].number).to eql 2
        expect(@ordered_tiles[2].colour).to eql "red"
      end

      it "will have a red 3 in the forth position" do
        expect(@ordered_tiles[3].number).to eql 3
        expect(@ordered_tiles[3].colour).to eql "red"
      end

      it "will have a red 5 in the last position" do
        expect(@ordered_tiles[4].number).to eql 5
        expect(@ordered_tiles[4].colour).to eql "red"
      end
    end
  end

  context "When moving from one tile_set to another" do
    context "When moving from the start to the start" do
      before do
        move = MoveTile.new(tile: tiles(:tile1),from: tile_sets(:set_valid_group), to: tile_sets(:set_valid_run), position: 0)
        move.call
        @ordered_from = tile_sets(:set_valid_group).tiles.order(:tile_set_order)
        @ordered_to = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will remove one element from the from set" do
        expect(@ordered_from.length).to eql 2
      end

      it "will have a blue 3 in the first position" do
        expect(@ordered_from[0].number).to eql 3
        expect(@ordered_from[0].colour).to eql "blue"
      end

      it "will have a black 3 in the second position" do
        expect(@ordered_from[1].number).to eql 3
        expect(@ordered_from[1].colour).to eql "black"
      end

      it "will have one more element in the to set" do
        expect(@ordered_to.length).to eql 4
      end

      it "will have a red 3 in the first position" do
        expect(@ordered_to[0].number).to eql 3
        expect(@ordered_to[0].colour).to eql "red"
      end

      it "will have a blue 5 in the second position" do
        expect(@ordered_to[1].number).to eql 5
        expect(@ordered_to[1].colour).to eql "blue"
      end

      it "will have a blue 6 in the second position" do
        expect(@ordered_to[2].number).to eql 6
        expect(@ordered_to[2].colour).to eql "blue"
      end

      it "will have a blue 7 in the second position" do
        expect(@ordered_to[3].number).to eql 7
        expect(@ordered_to[3].colour).to eql "blue"
      end
    end

    context "When moving from the end to the end" do
      before do
        move = MoveTile.new(tile: tiles(:tile3),from: tile_sets(:set_valid_group), to: tile_sets(:set_valid_run), position: 3)
        move.call
        @ordered_from = tile_sets(:set_valid_group).tiles.order(:tile_set_order)
        @ordered_to = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will remove one element from the from set" do
        expect(@ordered_from.length).to eql 2
      end

      it "will have a red 3 in the first position" do
        expect(@ordered_from[0].number).to eql 3
        expect(@ordered_from[0].colour).to eql "red"
      end

      it "will have a blue 3 in the second position" do
        expect(@ordered_from[1].number).to eql 3
        expect(@ordered_from[1].colour).to eql "blue"
      end

      it "will have one more element in the to set" do
        expect(@ordered_to.length).to eql 4
      end

      it "will have a blue 5 in the first position" do
        expect(@ordered_to[0].number).to eql 5
        expect(@ordered_to[0].colour).to eql "blue"
      end

      it "will have a blue 6 in the second position" do
        expect(@ordered_to[1].number).to eql 6
        expect(@ordered_to[1].colour).to eql "blue"
      end

      it "will have a blue 7 in the second position" do
        expect(@ordered_to[2].number).to eql 7
        expect(@ordered_to[2].colour).to eql "blue"
      end

      it "will have a black 3 in the second position" do
        expect(@ordered_to[3].number).to eql 3
        expect(@ordered_to[3].colour).to eql "black"
      end
    end

    context "When moving from the middle to middle" do
      before do
        move = MoveTile.new(tile: tiles(:tile2),from: tile_sets(:set_valid_group), to: tile_sets(:set_valid_run), position: 1)
        move.call
        @ordered_from = tile_sets(:set_valid_group).tiles.order(:tile_set_order)
        @ordered_to = tile_sets(:set_valid_run).tiles.order(:tile_set_order)
      end

      it "will remove one element from the from set" do
        expect(@ordered_from.length).to eql 2
      end

      it "will have a red 3 in the first position" do
        expect(@ordered_from[0].number).to eql 3
        expect(@ordered_from[0].colour).to eql "red"
      end

      it "will have a black 3 in the second position" do
        expect(@ordered_from[1].number).to eql 3
        expect(@ordered_from[1].colour).to eql "black"
      end

      it "will have one more element in the to set" do
        expect(@ordered_to.length).to eql 4
      end

      it "will have a blue 5 in the first position" do
        expect(@ordered_to[0].number).to eql 5
        expect(@ordered_to[0].colour).to eql "blue"
      end

      it "will have a blue 3 in the second position" do
        expect(@ordered_to[1].number).to eql 3
        expect(@ordered_to[1].colour).to eql "blue"
      end

      it "will have a blue 6 in the second position" do
        expect(@ordered_to[2].number).to eql 6
        expect(@ordered_to[2].colour).to eql "blue"
      end

      it "will have a blue 7 in the second position" do
        expect(@ordered_to[3].number).to eql 7
        expect(@ordered_to[3].colour).to eql "blue"
      end
    end
  end
end