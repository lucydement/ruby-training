require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games

  describe "POST #create" do
    before do
      expect(params).to receive(:require).and_return 4
    end

    it "creates a new game" do
      expect { post :create }.to change { Game.count }.by +1
    end

    it "creates the players" do
      post :create
      expect(Game.last.players.length).to eq 4
    end

    it "creates the tiles" do
      post :create
      expect(Game.last.tiles.length).to eq 104
    end

    it "redirects to the new game" do
      post :create
      expect(response).to redirect_to(Game.last)
    end
  end

  describe "GET show" do
    context "when show action is successful" do
      let(:get_current_player) {instance_double('GetCurrentPlayer', call: 0)}
      let(:tile_decorator) {instance_double('TileDecorator', call: 0)}

      before do
        allow(GetCurrentPlayer).to receive(:new).and_return(get_current_player)
        allow(TileDecorator).to receive(:new).and_return(tile_decorator)
      end

      it "redirects to the show page for that game" do
        get :show, id: 1
        expect(response).to render_template(:show)
      end

      it "finds the current player" do
        expect(get_current_player).to receive(:call).once

        get :show, id: 1
      end

      it "uses a tile decorator to find the json" do
        expect(tile_decorator).to receive(:call).once

        xhr :get, :show, id: 1
      end
    end
  end

  describe "PUT update" do
    let(:get_current_player) {instance_double('GetCurrentPlayer', call: 0)}
    let(:submit_move) {instance_double('SubmitMove', call: true)}

    before do
      allow(GetCurrentPlayer).to receive(:new).and_return(get_current_player)
      allow(SubmitMove).to receive(:new).and_return(submit_move)
    end

    it "finds the current player" do
      expect(get_current_player).to receive(:call).once

      xhr :put, :update, id: 1
    end

    it "will try to submit the move" do
      expect(Game).to receive(:find).and_return(games(:game5))
      expect(submit_move).to receive(:call).once

      xhr :put, :update, id: 1
    end

    it "will not submit the move if the game has ended" do
      expect(Game).to receive(:find).and_return(games(:set_game))
      expect(submit_move).to_not receive(:call)

      xhr :put, :update, id: 1
    end
  end
end