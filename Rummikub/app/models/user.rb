class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players, dependent: :restrict_with_error

  def player_for_game(game)
    players.detect {|player| player.game_id == game.id}
  end

  def not_in_game?(game)
    player_for_game(game).blank?
  end
end
