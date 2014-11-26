class Tile < ActiveRecord::Base
  belongs_to :bag
  belongs_to :hand
  belongs_to :tile_set

  validates :colour, null: false
  validates :number, inclusion: {in: (1..13)}
end
