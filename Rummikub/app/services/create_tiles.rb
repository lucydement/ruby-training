class CreateTiles
  def initialize(user_input)
    @user_input = user_input
  end

  def call
    return @user_input if @user_input == "drawTile"
    tiles = []
    @user_input.each do |input|
      tiles.push(Tile.new(id: input["id"], colour: input["colour"], number: input["number"], player_id: input["player_id"], on_board: input["on_board"], x: input["x"], y: input["y"]))
    end
    tiles
  end
end