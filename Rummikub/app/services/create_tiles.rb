class CreateTiles
  def initialize(user_input)
    puts "CREATE"
    puts user_input
    @user_input = user_input
  end

  def call
    return @user_input if @user_input == "drawTile"
    tiles = []
    @user_input.each do |input|
      if !input["x"]
        x = nil
      else
        x = input["x"].to_i
      end
      if !input["y"]
        y = nil
      else
        y = input["y"].to_i
      end
      
      tiles.push(Tile.new(id: input["id"].to_i, colour: input["colour"], number: input["number"].to_i, player_id: input["player_id"].to_i, on_board: input["on_board"], x: x, y: y))
    end
    tiles
  end
end