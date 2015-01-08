class Player < ActiveRecord::Base
  HAND_SIZE = 14

  belongs_to :game
  belongs_to :user
  has_many :tiles

  validates :game_id, :user_id, :number, presence: true
end
