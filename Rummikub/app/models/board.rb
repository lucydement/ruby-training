class Board < ActiveRecord::Base
  has_many :tile_sets
  belongs_to :game
end
