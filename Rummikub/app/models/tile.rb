class Tile < ActiveRecord::Base
  RANGE = (1..13)
  RED = "red"
  BLUE = "blue"
  BLACK = "black"
  YELLOW = "yellow"
  COLOURS = [RED, BLUE, BLACK, YELLOW]

  belongs_to :game
  belongs_to :player

  scope :in_bag, -> { where(player_id: nil, on_board: false) }
  scope :not_in_bag, -> { where("on_board = ? OR player_id", true) }

  validates :colour, presence: true, inclusion: {in: COLOURS}
  validates :number, presence: true, inclusion: {in: RANGE}
  validates :game_id, presence: true

  validate :only_in_one_of_player_or_board 
  validate :when_on_board_has_x_y
  validate :when_not_on_board_has_no_x_y
  validate :if_on_board_x_and_y_are_in_the_board

  def x_y_on_board?
    return false if x == nil || y == nil
    x >= 0 && x < Game::BOARD_WIDTH && y >= 0 && y < Game::BOARD_HEIGHT
  end

  def in_hand?
    player_id != nil
  end

  private

  def only_in_one_of_player_or_board
    if player_id && on_board
      errors.add(:player_id, "Is in players hand and on the board")
    end
  end

  def when_on_board_has_x_y
    if on_board && (!x || !y)
      errors.add(:on_board, "It is on board but has no x and y")
    end
  end

  def when_not_on_board_has_no_x_y
    if !on_board && (x || y)
      errors.add(:on_board, "It is not on the board but has x and y")
    end
  end

  def if_on_board_x_and_y_are_in_the_board
    if x_and_y_out_bounds
      errors.add(:on_board, "The x and y are out of bounds")
    end
  end

  def x_and_y_out_bounds
    return false unless x && y
    x < 0 || x >= Game::BOARD_WIDTH || y < 0 || y >= Game::BOARD_HEIGHT
  end
end
