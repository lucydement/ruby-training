class Game < ActiveRecord::Base
  #NUMBER_PLAYERS = 4
  BOARD_WIDTH = 16
  BOARD_HEIGHT = 8

  has_many :tiles, dependent: :destroy
  has_many :players, dependent: :destroy 

  validates :number_players, inclusion: {in: (2..4)}
  validates :number_players, presence: true

  def bag
    tiles.in_bag
  end

  def won?
    winning_player.present?
  end

  def winning_player
    players.detect {|player| player.tiles.empty?}
  end

  def ended?
    won? || (bag.empty? && players.all?(&:passed))
  end
end