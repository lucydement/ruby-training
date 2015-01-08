class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players

  def player_for_game(game)
    players.find {|player| player.game_id == game.id}
  end

  def not_in_game(game)
    player_for_game(game).blank?
  end
end
