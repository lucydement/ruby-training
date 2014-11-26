class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game_id, presence: true
  validates :letter, format: { with: /\A[a-z]\z/ }
end
