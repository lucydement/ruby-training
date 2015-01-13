class Tile < ActiveRecord::Base
  RANGE = 1..13  #NUMBERS
  RED = "red"
  BLUE = "blue"
  BLACK = "black"
  YELLOW = "yellow"
  COLOURS = [RED, BLUE, BLACK, YELLOW]

  belongs_to :game
  belongs_to :player

  scope :in_bag, -> { where(player_id: nil, on_board: false) }
  scope :not_in_bag, -> { where("on_board OR player_id") }

  validates :colour, inclusion: {in: COLOURS}
  validates :number, inclusion: {in: RANGE}
  validates :game_id, presence: true

  validate :only_in_one_of_player_or_board 
  validate :when_on_board_has_x_y
  validate :when_not_on_board_has_no_x_y
  validate :x_and_y_are_in_bounds

  validates :x, :y, presence: {message: "cannot be true with no x and y"}, if: :on_board

  private

  def only_in_one_of_player_or_board
    if player_id && on_board
      errors.add(:player_id, "cannot be true if on_board is also true")
    end
  end

  def when_on_board_has_x_y
    if on_board && (!x || !y)
      errors.add(:on_board, "cannot be true with no x and y")
    end
  end

  def when_not_on_board_has_no_x_y
    if !on_board && (x || y)
      errors.add(:on_board, "cannot be false if it has x and y values")
    end
  end

  def x_and_y_are_in_bounds
    if x_and_y_out_of_bounds?
      errors.add(:x, "and y cannot be out of bounds")
    end
  end

  def x_and_y_out_of_bounds?  #switch and use include
    return false unless x && y
    x < 0 || x >= Game::BOARD_WIDTH || y < 0 || y >= Game::BOARD_HEIGHT
  end
end
