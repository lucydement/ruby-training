class Game < ActiveRecord::Base
  BOARD_WIDTH = 16
  BOARD_HEIGHT = 8

  has_many :tiles, dependent: :destroy
  has_many :players, dependent: :destroy 

  validates :number_players, inclusion: {in: NumberPlayersPolicy::POSSIBLE}
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

  def not_enough_users?
    players.any? {|player| !player.has_user}
  end

  def get_free_player
    players.find {|player| !player.has_user}
  end

  def user_not_in_game?(current_user)
    !players.detect {|player| player.users.first == current_user}
  end

  def playing_user
    playing_player = players.find {|player| player.number == current_player}
    playing_player.users.first
  end

  def current_users_player_id(current_user)
    user_player = players.find {|player| player.users.first == current_user}
    if user_player != nil
      user_player.id
    end
  end
end