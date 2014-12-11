class SubmitMove
  def initialize(game, player, user_input) 
    @game = game
    @player = player
    @user_input = user_input
  end

  def call
    tiles = CreateTiles.new(@user_input).call

    if @user_input == "drawTile"
      DrawTile.new(player: @player ,game: @game).call
      UpdateCurrentPlayer.new(@game).call
      true
    elsif ValidateBoard.new(tiles).call
      UpdateGame.new(@game, tiles, @player).call
      UpdateCurrentPlayer.new(@game).call
      true
    else
      false
    end
  end
end