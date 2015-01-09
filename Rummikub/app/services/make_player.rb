class MakePlayer
  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    Game.transaction do
      @game.lock!
      @user.reload
      if @game.not_enough_players? && @user.not_in_game(@game)
        player = @game.players.create!(user_id: @user.id, number: @game.players.length, passed: false)
        
        Player::HAND_SIZE.times do
          tile = @game.bag.sample
          tile.update_attributes!(player_id: player.id)
        end
      end
    end
  end
end