class Tile < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :tile_set

  validates :colour, presence: true
  validates :number, presence: true, inclusion: {in: (1..13)}
  validates :game_id, presence: true

  validate :only_in_one_of_player_or_tile_set 
  validate :when_in_tile_set_has_order

  def only_in_one_of_player_or_tile_set
    errors.add(:player_id, "invalid") if player_id && tile_set_id
  end

  def when_in_tile_set_has_order
    errors.add(:tile_set_order, "invalid") if tile_set_id && !tile_set_order
  end

  def is_in_hand?
    player_id
  end

  def is_in_set?
    tile_set_id
  end
end
