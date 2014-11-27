require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
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
end