require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  fixtures :users, :games

  let(:make_player) {instance_double('MakePlayer', call: true)}

  before do
    sign_in users(:user_2)
    allow(MakePlayer).to receive(:new).and_return make_player
  end

  describe "POST #create" do
    it "makes a new player" do
      expect(make_player).to receive(:call).once

      post :create, game_id: games(:set_game).id
    end

    it "redirects to the game" do
      post :create, game_id: games(:full_game).id
      expect(response).to redirect_to(games(:full_game))
    end
  end
end