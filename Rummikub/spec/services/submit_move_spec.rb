require 'rails_helper'

RSpec.describe SubmitMove do
  let(:game) {instance_double('Game', reload: true)}
  let(:player) {instance_double('Player')}
  let(:draw_tile) {instance_double('DrawTile', call: 0)}
  let(:update_active_player) {instance_double('UpdateActivePlayer', call: 0)}
  let(:update_game) {instance_double('UpdateGame', call: 0)}
  let(:create_tiles) {instance_double('CreateTiles', call: 0)}
  let(:get_active_player) {instance_double('GetActivePlayer', call: player)}

  context "When the user draw a tile" do
    before do
      allow(DrawTile).to receive(:new).and_return draw_tile
      allow(UpdateActivePlayer).to receive(:new).and_return update_active_player
      allow(UpdateGame).to receive(:new).and_return update_game
      allow(CreateTiles).to receive(:new).and_return create_tiles
      allow(GetActivePlayer).to receive(:new).and_return get_active_player
    end

    let(:submit_move) {SubmitMove.new(game, "drawTile")}

    it "will draw a tile for the player" do
      expect(draw_tile).to receive(:call).once

      submit_move.call
    end

    it "will find the next player" do
      expect(update_active_player).to receive(:call).once

      submit_move.call
    end

    it "will return true as it was sucessful" do
      expect(submit_move.call).to be_truthy
    end

    it "will create the tiles from the user input" do
      expect(create_tiles).to receive(:call).once

      submit_move.call
    end
  end

  context "When the user submits some invalid move" do
    before do
      allow(DrawTile).to receive(:new).and_return draw_tile
      allow(UpdateActivePlayer).to receive(:new).and_return update_active_player
      allow(UpdateGame).to receive(:new).and_return update_game
      allow(CreateTiles).to receive(:new).and_return create_tiles
      allow(GetActivePlayer).to receive(:new).and_return get_active_player
    end

    let(:validate_board) {instance_double('ValidateBoard', call: false)}
    let(:submit_move) {SubmitMove.new(game, "Invalid move")}

    before do
      allow(ValidateBoard).to receive(:new).and_return validate_board
    end

    it "will validate the move" do
      expect(validate_board).to receive(:call).once

      submit_move.call
    end

    it "will return false as this is not a valid move" do
      expect(submit_move.call).to be_falsey
    end

    it "will create the tiles from the user input" do
      expect(create_tiles).to receive(:call).once

      submit_move.call
    end
  end

  context "When the user submits some valid move" do
    let(:validate_board) {instance_double('ValidateBoard', call: true)}
    let(:submit_move) {SubmitMove.new(game, "Valid move")}


    before do
      allow(ValidateBoard).to receive(:new).and_return validate_board
      allow(DrawTile).to receive(:new).and_return draw_tile
      allow(UpdateActivePlayer).to receive(:new).and_return update_active_player
      allow(UpdateGame).to receive(:new).and_return update_game
      allow(CreateTiles).to receive(:new).and_return create_tiles
      allow(GetActivePlayer).to receive(:new).and_return get_active_player
    end

    it "will call validate move" do
      expect(validate_board).to receive(:call).once

      submit_move.call
    end

    it "will update the game" do
      expect(update_game).to receive(:call).once

      submit_move.call
    end

    it "will find the next player" do
      expect(update_active_player).to receive(:call).once

      submit_move.call
    end

    it "will return true as it was a valid move" do
      expect(submit_move.call).to be_truthy
    end

    it "will create the tiles from the user input" do
      expect(create_tiles).to receive(:call).once

      submit_move.call
    end
  end
end