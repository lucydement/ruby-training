class CreateTiles
  def initialize(user_input)
    @user_input = user_input
  end

  def call
    return @user_input if @user_input == "drawTile"
    tiles = []
    @user_input.each do |input|
      x = input["x"] ? input["x"].to_i : nil
      y = input["y"] ? input["y"].to_i : nil
      player_id = input["player_id"] ? input["player_id"].to_i : nil
      
      tiles.push(Tile.new(id: input["id"].to_i, colour: input["colour"], number: input["number"].to_i, player_id: player_id, on_board: input["on_board"], x: x, y: y))
    end
    tiles
  end
end