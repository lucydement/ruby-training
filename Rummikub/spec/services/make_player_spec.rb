require 'rails_helper'

RSpec.describe MakePlayer do
  let(:game) { SetupGame.new(4).call }
  let(:user) {instance_double('User', id: 1)}
  let(:make_player) { MakePlayer.new(game,user) }

  it "make a new player" do
    expect {make_player.call}.to change {game.players.length}.by +1
  end

  it "assigns the player to the user" do
    make_player.call

    expect(game.players.first.user_id).to eql 1
  end

  it "gives the player 14 tiles" do
    make_player.call

    expect(game.players.first.tiles.length).to eql 14
  end
end