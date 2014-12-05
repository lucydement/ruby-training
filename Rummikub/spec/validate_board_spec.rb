require_relative 'rails_helper'

RSpec.describe ValidateBoard do
  context "When running" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>0, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>7, "game_id"=>2, "player_id"=>nil, "on_board"=>true, "x"=>0, "y"=>1}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "doesn't bug out horribly" do
      @validate_board.call
    end
  end

  context "When one valid group" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When one valid run" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"red", "number"=>13, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When one invalid group" do
    it "is a invalid board when two colours the same" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end

    it "is a invalid board when not all the same number" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"blue", "number"=>2, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end
  end

  context "When on invalid run" do
    it "is an invalid board when they are not in order" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>3, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"red", "number"=>2, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3}]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end

    it "is an invalid board when they are differnt colours" do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"black", "number"=>2, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"blue", "number"=>3, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3}]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end
  end

  context "When two valid sets in one row" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3},
        {"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>nil, "on_board"=>true, "x"=>11, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>nil, "on_board"=>true, "x"=>12, "y"=>3},
        {"id"=>115, "colour"=>"red", "number"=>13, "player_id"=>nil, "on_board"=>true, "x"=>13, "y"=>3}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When one valid and one invalid set in one line" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3},
        {"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>nil, "on_board"=>true, "x"=>11, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>nil, "on_board"=>true, "x"=>12, "y"=>3},
        {"id"=>115, "colour"=>"black", "number"=>13, "player_id"=>nil, "on_board"=>true, "x"=>13, "y"=>3}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is an invalid board" do
      expect(@validate_board.call).to be_falsey
    end
  end

  context "When tiles out of bounds" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>1, "on_board"=>true, "x"=>1, "y"=>3},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>3},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>3},
        {"id"=>105, "colour"=>"red", "number"=>11, "player_id"=>5, "on_board"=>true, "x"=>16, "y"=>3},
        {"id"=>158, "colour"=>"red", "number"=>12, "player_id"=>5, "on_board"=>true, "x"=>12, "y"=>8},]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "it doesn't effect the outcome" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When a tile is moved from the board to hand" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>0, "y"=>8}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "it to be invalid" do
      expect(@validate_board.call).to be_falsey
    end
  end

  context "A player must add a least one tile from there hand to the board" do
    before do
      tiles = [{"id"=>105, "colour"=>"red", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>1, "y"=>0},
        {"id"=>158, "colour"=>"black", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>2, "y"=>0},
        {"id"=>115, "colour"=>"blue", "number"=>1, "player_id"=>nil, "on_board"=>true, "x"=>3, "y"=>0}]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is an invalid board" do
      expect(@validate_board.call).to be_falsey
    end
  end 
end