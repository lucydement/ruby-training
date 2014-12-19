class Game < ActiveRecord::Base
  BOARD_WIDTH = 16
  BOARD_HEIGHT = 8

  has_many :tiles, dependent: :destroy
  has_many :players, dependent: :destroy 

  validates :total_player_count, inclusion: {in: NumberPlayersPolicy::POSSIBLE}

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

  def number_players
    players.length
  end

  def not_enough_players?
    number_players < total_player_count
  end
end