class MakePlayer
  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    Game.transaction do
      @game.lock!
      @user.reload

      bag = @game.bag.shuffle

      if @game.not_enough_players? && @user.not_in_game?(@game)
        player = @game.players.create!(user: @user, number: @game.players.length, passed: false)
        
        Player::HAND_SIZE.times do
          tile = bag.pop
          tile.update_attributes!(player: player)
        end
      end
    end
  end
end