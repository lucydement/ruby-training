class MakePlayer
  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    Game.transaction do
      @game.reload(lock: true)
      @user.reload
      if @game.not_enough_players? && UserNotInGame.new(@game, @user).call
        player = @game.players.create!(user_id: @user.id, number: @game.number_players)
        
        Player::HAND_SIZE.times do
          tile = @game.bag.sample
          tile.update_attributes!(player_id: player.id)
        end
      end
    end
  end
end