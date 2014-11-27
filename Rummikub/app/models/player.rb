class Player < ActiveRecord::Base
  belongs_to :game
  has_many :tiles

  validates :game_id , presence: true
end
