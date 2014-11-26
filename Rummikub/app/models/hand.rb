class Hand < ActiveRecord::Base
  has_many :tiles
  belongs_to :player
end
