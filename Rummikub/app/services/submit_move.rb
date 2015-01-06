class SubmitMove
  def initialize(game, user_input) 
    @game = game
    @user_input = user_input
  end

  def call
    Game.transaction do
      @game.reload(lock: true)
      player = GetActivePlayer.new(@game).call
      tiles = CreateTiles.new(@user_input, @game).call

      if @user_input == "drawTile"
        DrawTile.new(player: player ,game: @game).call
        UpdateActivePlayer.new(@game).call
        true
      elsif ValidateBoard.new(tiles).call
        UpdateGame.new(tiles, @game, player).call
        UpdateActivePlayer.new(@game).call
        true
      else
        false
      end
    end
  end
end