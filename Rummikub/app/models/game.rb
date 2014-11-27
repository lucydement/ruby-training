class Game < ActiveRecord::Base
  has_many :tiles
  has_many :players
  has_many :tile_sets

  def setup
    (1..4).each{players.create}
  end
end
