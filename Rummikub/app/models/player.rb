class Player < ActiveRecord::Base
  has_many :hands
  belongs_to :game
end
