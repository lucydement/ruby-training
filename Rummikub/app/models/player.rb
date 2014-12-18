class Player < ActiveRecord::Base
  HAND_SIZE = 14

  belongs_to :game
  has_many :tiles
  belongs_to :user

  validates :game_id, :user_id, :number, presence: true

  def user
    User.find {|user| user.id == user_id}
  end
end
