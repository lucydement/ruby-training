class Tile < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :colour, presence: true
  validates :number, presence: true, inclusion: {in: (1..13)}
  validates :game_id, presence: true

  validate :only_in_one_of_player_or_board 
  validate :when_on_board_has_x_y
  validate :when_not_on_board_has_no_x_y

  def only_in_one_of_player_or_board
    errors.add(:player_id, "invalid") if player_id && on_board
  end

  def when_on_board_has_x_y
    errors.add(:tile_set_id, "invalid") if on_board && (!x || !y)
  end

  def when_not_on_board_has_no_x_y
    errors.add(:tile_set_id, "invalid") if !on_board && (x || y)
  end

  def is_in_hand?
    player_id
  end

  def is_on_board?
    on_board
  end
end
