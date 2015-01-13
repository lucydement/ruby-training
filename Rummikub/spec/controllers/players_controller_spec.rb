require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  fixtures :users

  let(:make_player) {instance_double('MakePlayer', call: true)}
  let(:game) {instance_double('Game', id: 1)}

  before do
    sign_in users(:user_2)
    allow(Game).to receive(:find).and_return game
  end

  describe "POST #create" do
    it "makes a new player" do #use fixtures
      expect(MakePlayer).to receive(:new).with(game, users(:user_2)).and_return make_player
      expect(make_player).to receive(:call).once

      allow(controller).to receive(:redirect_to).with(game)
      allow(controller).to receive(:render)
      post :create, game_id: game.id
    end

    it "redirects to the game" do
      allow(MakePlayer).to receive(:new).and_return make_player

      expect(controller).to receive(:redirect_to).with(game)
      expect(controller).to receive(:render)

      post :create, game_id: game.id
    end
  end
end