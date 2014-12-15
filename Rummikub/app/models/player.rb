class Player < ActiveRecord::Base
  HAND_SIZE = 14

  belongs_to :game
  has_many :tiles
  has_many :users

  validates :game_id, presence: true
  validates :number, presence: true

  validate :has_at_most_one_user

  def has_at_most_one_user
    users.length <= 1
  end

  def has_user
    users.length == 1
  end
end
