class SetupGame
  def initialize(number_players)
    @number_players = number_players
  end

  def call
    Game.transaction do
      @game = Game.create!(number_players: @number_players)
      create_tiles
      create_players_and_draw_hands
      @game.update_attributes!(current_player: 0) #default?
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

  def create_players_and_draw_hands
    @game.number_players.times do |i|
      player = @game.players.create!(number: i)

      Player::HAND_SIZE.times do
        tile = @game.bag.sample
        tile.update_attributes!(player_id: player.id)
      end
    end
  end
end