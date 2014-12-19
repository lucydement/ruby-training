require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games, :users

  before do
    sign_in users(:user_1)
  end

  describe "POST #create" do
    it "creates a new game" do
      expect { post :create, { :game => {:total_player_count => 4}} }.to change { Game.count }.by +1
    end

    it "will not create a game if invalid number of players" do
      expect { post :create, { :game => {:total_player_count => 1}} }.to_not change { Game.count }
    end

    it "will redirect to the index page if creation fails" do
      post :create, { :game => {:total_player_count => 1}}
      expect(response).to redirect_to(games_path)
    end

    it "creates the tiles" do
      post :create, { :game => {:total_player_count => 4}}
      expect(Game.last.tiles.length).to eq 104
    end

    it "redirects to the new game" do
      post :create, { :game => {:total_player_count => 4}}
      expect(response).to redirect_to(Game.last)
    end
  end

  describe "GET show" do
    let(:get_active_player) {instance_double('GetActivePlayer', call: 0)}
    let(:tile_decorator) {instance_double('TileDecorator', call: 0)}

    before do
      allow(GetActivePlayer).to receive(:new).and_return(get_active_player)
      allow(TileDecorator).to receive(:new).and_return(tile_decorator)
    end

    it "redirects to the show page for that game" do
      get :show, id: 1
      expect(response).to render_template(:show)
    end

    it "finds the active player" do
      expect(get_active_player).to receive(:call).once

      get :show, id: 1
    end

    it "uses a tile decorator to find the json" do
      expect(tile_decorator).to receive(:call).once

      xhr :get, :show, id: 1
    end
  end

  describe "PUT update" do
    let(:get_active_player) {instance_double('GetActivePlayer', call: 0)}
    let(:submit_move) {instance_double('SubmitMove', call: true)}

    before do
      allow(GetActivePlayer).to receive(:new).and_return(get_active_player)
      allow(SubmitMove).to receive(:new).and_return(submit_move)
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