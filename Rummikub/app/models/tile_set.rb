class TileSet < ActiveRecord::Base
  has_many :tiles
  belongs_to :board
end
