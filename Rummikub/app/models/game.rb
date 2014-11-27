class Game < ActiveRecord::Base
  has_many :tiles
  has_many :players
  has_many :tile_sets

  def setup
    (1..4).each{players.create}
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
  end
end
