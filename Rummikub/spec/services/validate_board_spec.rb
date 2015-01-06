require_relative '../rails_helper'

RSpec.describe ValidateBoard do
  context "When running" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: nil, on_board: true, x: 0, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 7, game_id: 2, player_id: nil, on_board: true, x: 0, y: 1, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "doesn't bug out horribly" do
      @validate_board.call
    end
  end

  context "When one valid group" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 0, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When one valid run" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: 1, on_board: true, x: 1, y: 3, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: nil, on_board: true, x: 2, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::RED, number: 13, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "A group is invalid when" do
    it "has two colours the same" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 0, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 3, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3, on_board_was: true, player_id_was: 3)]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end

    it "has tiles that are not all the same number" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 0, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 2, player_id: nil, on_board: true, x: 3, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end
  end

  context "A run is invaild when" do
    it "has tiles that are not in order" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 3, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 3, player_id: nil, on_board: true, x: 2, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::RED, number: 2, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end

    it "it has tiles that are differnt colours" do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 3, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 2, player_id: nil, on_board: true, x: 2, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 3, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      validate_board = ValidateBoard.new(tiles)

      expect(validate_board.call).to be_falsey
    end
  end

  context "When two valid sets in one row" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 3, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: nil, on_board: true, x: 11, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: nil, on_board: true, x: 12, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::RED, number: 13, player_id: nil, on_board: true, x: 13, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is a valid board" do
      expect(@validate_board.call).to be_truthy
    end
  end

  context "When one valid and one invalid set in one line" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 1, on_board: true, x: 1, y: 3, in_hand?: true, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: nil, on_board: true, x: 11, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: nil, on_board: true, x: 12, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLACK, number: 13, player_id: nil, on_board: true, x: 13, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is an invalid board" do
      expect(@validate_board.call).to be_falsey
    end
  end

  context "When tiles out of bounds" do
    before do
      tiles = [instance_double('Tile', id: 115, colour: Tile::RED, number: 10, player_id: nil, on_board: true, x: 3, y: 3, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 105, colour: Tile::RED, number: 11, player_id: 5, on_board: true, x: 16, y: 3, in_hand?: true, x_y_on_board?: false, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::RED, number: 12, player_id: 5, on_board: true, x: 12, y: 8, in_hand?: true, x_y_on_board?: false, on_board_was: true, player_id_was: 3)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "it should be invalid" do
      expect(@validate_board.call).to be_falsey
    end
  end

  context "When a tile is moved from the board to hand" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: 3, on_board: false, x: 0, y: 8, in_hand?: false, x_y_on_board?: false, on_board_was: true, player_id_was: nil)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is invalid" do
      expect(@validate_board.call).to be_falsey
    end
  end

  context "A player must add a least one tile from there hand to the board" do
    before do
      tiles = [instance_double('Tile', id: 105, colour: Tile::RED, number: 1, player_id: nil, on_board: true, x: 1, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 158, colour: Tile::BLACK, number: 1, player_id: nil, on_board: true, x: 2, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil),
        instance_double('Tile', id: 115, colour: Tile::BLUE, number: 1, player_id: nil, on_board: true, x: 3, y: 0, in_hand?: false, x_y_on_board?: true, on_board_was: true, player_id_was: nil)]
      @validate_board = ValidateBoard.new(tiles)
    end

    it "is an invalid board if they don't" do
      expect(@validate_board.call).to be_falsey
    end
  end 
end