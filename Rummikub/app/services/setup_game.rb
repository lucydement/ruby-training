class SetupGame
  def initialize(game)
    @game = game
  end

  def call

    create_tiles
    create_players_and_draw_hands
    @game.update_attributes!(current_player: 0) #default?
  end

  private

  def create_tiles
    Tile::RANGE.each do |tile_number|
      @game.tiles.create!(colour: Tile::RED, number: tile_number) 
      @game.tiles.create!(colour: Tile::RED, number: tile_number)
      @game.tiles.create!(colour: Tile::BLUE, number: tile_number)
      @game.tiles.create!(colour: Tile::BLUE, number: tile_number)
      @game.tiles.create!(colour: Tile::BLACK, number: tile_number)
      @game.tiles.create!(colour: Tile::BLACK, number: tile_number)
      @game.tiles.create!(colour: Tile::YELLOW, number: tile_number)
      @game.tiles.create!(colour: Tile::YELLOW, number: tile_number) 
    end
  end

  def create_players_and_draw_hands
    (0..Game::NUMBER_PLAYERS - 1).each do |i|
      player = @game.players.create(number: i)
      (1..Player::HAND_SIZE).each do
        tile = @game.bag.sample
        tile.update_attributes!(player_id: player.id)
      end
    end
  end
end