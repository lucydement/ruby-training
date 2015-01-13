class SetupGame  #create game
  def initialize(number_players)
    @number_players = number_players
  end
  
  def call
    Game.transaction do
      @game = Game.create!(total_player_count: @number_players, active_player_number: 0)
      create_tiles
      @game
    end
  end

  private
 
  def create_tiles
    Tile::RANGE.each do |tile_number|
      Tile::COLOURS.each do |colour|
        2.times {@game.tiles.create!(colour: colour, number: tile_number)}
      end
    end
  end
end