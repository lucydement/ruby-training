class Game < ActiveRecord::Base
  has_many :tiles
  has_many :players
  has_many :tile_sets


  def bag
    tiles.where(player_id: nil, tile_set_id: nil)
  end

  def setup
    (1..13).each do |t|
      tiles.create(colour: "red", number: t) 
      tiles.create(colour: "red", number: t)
      tiles.create(colour: "blue", number: t)
      tiles.create(colour: "blue", number: t)
      tiles.create(colour: "black", number: t)
      tiles.create(colour: "black", number: t)
      tiles.create(colour: "yellow", number: t)
      tiles.create(colour: "yellow", number: t) 
    end

    (1..4).each do 
      player = players.create
      (1..14).each do
        tile = bag.sample
        tile.update_attributes(player_id: player.id)
      end
    end

    #For testing, REMEMBER TO DELETE
    # tile_set = tile_sets.create
    # bag.sample.update_attributes(tile_set_id: tile_set.id, tile_set_order: 0, x: 0, y: 0)
    # tile_set1 = tile_sets.create
    # bag.sample.update_attributes(tile_set_id: tile_set1.id, tile_set_order: 0, x: 1, y: 1)
  end
end