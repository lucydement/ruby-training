require 'rails_helper'

RSpec.describe MakePlayer do
  fixtures :games, :users

  let(:game) { SetupGame.new(4).call } #name argument
  let(:user) {instance_double('User', id: 1, reload: true, not_in_game?: true)}
  let(:make_player) { MakePlayer.new(game,user) }

  it "makes a new player" do
    expect {make_player.call}.to change {game.players.length}.by +1
  end

  it "assigns the player to the user" do
    make_player.call

    expect(game.players.first.user).to eq user
  end

  it "gives the player 14 tiles" do
    make_player.call

    expect(game.players.first.tiles.length).to eql 14
  end

  it "makes passed false" do
    make_player.call

    expect(game.players.first.passed).to eql false
  end
  #split into contexts
  it "doesn't make a new player if that game is full" do
    game1 = games(:full_game)
    make_player1 = MakePlayer.new(game1, users(:user_2))

    expect {make_player1.call}.to_not change {game1.players.length}
  end

  it "doesn't make a new player if the user is already in the game" do
    game1 = games(:game1)
    make_player1 = MakePlayer.new(game1, users(:user_2))

    expect {make_player1.call}.to_not change {game1.players.length}
  end
end