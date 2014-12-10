class SubmitMove
  def initialize(game, player, user_input) 
    @game = game
    @player = player
    @user_input = user_input
  end

  def call
    if @user_input == "drawTile"
      DrawTile.new(player: @player ,game: @game).call
      NextPlayer.new(@game).call
      true

    elsif ValidateBoard.new(@user_input).call
      UpdateGame.new(@game, @user_input, @player).call
      NextPlayer.new(@game).call
      true

    else
      false
    end
  end
end