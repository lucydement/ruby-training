require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :users, :games

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

    it "redirects to the new game" do
      post :create, { :game => {:total_player_count => 4}}
      expect(response).to redirect_to(Game.last)
    end
  end

  describe "GET show" do
    before do
      allow(GamesDelegator).to receive(:new).and_return games(:game3)
    end
    
    it "renders correct json" do
      xhr :get, :show, id: 1
      
      expect(response.body).to eql games(:game3).tiles.not_in_bag.to_json
    end

    it "should render show"
  end

  describe "PUT update" do #wouldn't use instance_doubles
    let(:submit_move) {instance_double('SubmitMove', call: true)}
    let(:game) {instance_double('Game', ended?: false)}
    let(:ended_game) {instance_double('Game', ended?: true)}

    before do
      allow(SubmitMove).to receive(:new).and_return(submit_move)
    end

    it "will try to submit the move" do
      expect(Game).to receive(:find).and_return(game)
      expect(submit_move).to receive(:call).once

      xhr :put, :update, id: 1
    end

    it "will not submit the move if the game has ended" do
      expect(Game).to receive(:find).and_return(ended_game)
      expect(submit_move).to_not receive(:call)

      xhr :put, :update, id: 1
    end
  end
end