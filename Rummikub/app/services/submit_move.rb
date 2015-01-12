class SubmitMove
  InvalidSubmitError = Class.new(StandardError)

  def initialize(game, game_tiles, draw_tile) 
    @game = game
    @game_tiles = game_tiles
    @draw_tile = draw_tile
  end

  def call
    if @game_tiles && @draw_tile
      raise InvalidSubmitError
    end

    Game.transaction do
      @game.lock!
      tiles = CreateTiles.new(@game_tiles, @game).call

      if @draw_tile
        DrawTile.new(@game).call
        UpdateActivePlayer.new(@game).call
        true
      elsif ValidateBoard.new(tiles).call
        UpdateGame.new(tiles, @game).call
        UpdateActivePlayer.new(@game).call
        true
      else
        false
      end
    end
  end
end