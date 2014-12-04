class Game < ActiveRecord::Base
  has_many :tiles
  has_many :players

  def bag
    tiles.where(player_id: nil, on_board: nil)
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
  end
end