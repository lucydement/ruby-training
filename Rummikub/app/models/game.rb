class Game < ActiveRecord::Base
  BOARD_WIDTH = 16
  BOARD_HEIGHT = 8

  has_many :tiles, dependent: :destroy
  has_many :players, dependent: :destroy 

  validates :total_player_count, inclusion: {in: NumberPlayersPolicy::POSSIBLE_PLAYERS}

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
    won? || (bag.empty? && players.all?(&:passed?))
  end

  def not_enough_players?
    players.length < total_player_count
  end

  def begun?
    players.length == total_player_count
  end

  def active_player
    players.where(number: active_player_number).first
  end
end