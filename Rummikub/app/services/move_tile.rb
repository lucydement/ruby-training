class MoveTile
  def initialize(tile:,from:, to:, position:)
    @tile = tile
    @from = from
    @to = to
    @position = position
    if @position < 0 || @position > @to.tiles.length
      raise("invalid position")
    end
  end

  def call
    if @tile.is_in_hand? #&& @tile_set.instance_of? TileSet
      #moving from players hand to tile_set
      insert(tile: @tile, tile_set: @to, position: @position)
    elsif @tile.is_in_set? #&& @tile_set.instance_of? TileSet
      remove(tile: @tile, tile_set: @from)
      insert(tile: @tile, tile_set: @to, position: @position)
    else
      raise("invalid use of moveTile")
    end  
  end

  private

  def insert(tile:, tile_set:, position:)
    tiles = tile_set.tiles.sort_by {|tile| tile.tile_set_order}
      (position..tiles.length - 1).each do |t|
        tiles[t].update_attributes!(tile_set_order: t + 1)
      end

      tile.update_attributes!(player_id: nil, tile_set_id: tile_set.id, tile_set_order: position)
  end

  def remove(tile:, tile_set:)
    tiles = tile_set.tiles.sort_by {|tile| tile.tile_set_order}
    (tile.tile_set_order + 1..tiles.length - 1).each do |t|
      tiles[t].update_attributes!(tile_set_order: t - 1)
    end
  end
end