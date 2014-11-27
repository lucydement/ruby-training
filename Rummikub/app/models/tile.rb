class Tile < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :tile_set

  validates :colour, presence: true
  validates :number, presence: true, inclusion: {in: (1..13)}
  validates :game_id, presence: true

  validate :only_in_one_of_player_or_tile_set 

  def only_in_one_of_player_or_tile_set
    errors.add(:player_id, "invalid") if player_id && tile_set_id
  end
end
