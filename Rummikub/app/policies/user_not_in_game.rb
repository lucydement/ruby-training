class UserNotInGame
  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    !@game.players.detect {|player| player.user_id == @user.id}
  end
end