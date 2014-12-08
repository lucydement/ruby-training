require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games

  describe "POST #create" do
    it "creates a new game" do
      expect { post :create }.to change { Game.count }.by +1
    end

    it "sets up the game with players" do
      post :create
      expect(Game.last.players.length).to eq 4
    end

    it "sets up the game with tiles" do
      post :create
      expect(Game.last.tiles.length).to eq 104
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

      it "calls get_current_player" do
        expect(get_current_player).to receive(:call).once

        get :show, id: 1
      end

      it "calls tile decorator" do
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

    it "will call get_current_player" do
      expect(get_current_player).to receive(:call).once

      xhr :put, :update, id: 1
    end

    it "will call submit_move" do
      expect(get_current_player).to receive(:call).once

      xhr :put, :update, id: 1
    end

    it "will not call submit_move if the game has ended" do
      expect(get_current_player).to_not receive(:call)

      xhr :put, :update, id: games(:set_game) 
    end
  end
end