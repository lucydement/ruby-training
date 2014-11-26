class Game < ActiveRecord::Base
  has_many :boards
  has_many :bags
  has_many :players
end
