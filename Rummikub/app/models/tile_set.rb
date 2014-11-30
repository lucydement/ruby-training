class TileSet < ActiveRecord::Base
  belongs_to :game
  has_many :tiles

  validates :game_id, presence: true

  def valid_set?
    if tiles.empty?
      return true
    end
    if tiles.length < 3
      return false
    end
    if tiles[0].colour == tiles[1].colour
      valid_run?
    else
      valid_group?
    end
  end

  def valid_run?
    colours = tiles.map{|tile| tile.colour}.uniq
    return false if colours.length > 1
    ordered_tiles = tiles.order(:tile_set_order)
    numbers = ordered_tiles.map{|tile| tile.number}
    
    (1..numbers.length - 1).each do |t|
      return false if numbers[t] - numbers[t-1] != 1
    end
    true
  end

  def valid_group?
    numbers = tiles.map{|tile| tile.number}.uniq
    return false if numbers.length > 1

    colours = tiles.map{|tile| tile.colour}.uniq
    return false if colours.length < tiles.length
    true
  end
end
