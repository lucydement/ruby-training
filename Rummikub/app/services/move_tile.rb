class MoveTile
  def initialize(tile:, to:, position:)
    @tile = tile
    @tile_set = to
    @position = position
  end

  def call
    if @tile.player_id #&& @tile_set.instance_of? TileSet
      #moving from players hand to tile_set
      tiles = @tile_set.tiles.order(:tile_set_order)
      (@position..tiles.length - 1).each do |t|
        tiles[t].update_attributes(tile_set_order: t + 1)
      end

      @tile.update_attributes(player_id: nil, tile_set_id: @tile_set.id, tile_set_order: @position)
    elsif @tile.tile_set_id == @tile_set.id #&& @tile_set.instance_of? TileSet
      #moving tile within the same tile_set
      tiles = @tile_set.tiles.order(:tile_set_order)
      if @tile.tile_set_order < @position
        (@tile.tile_set_order + 1..@position - 1).each do |t|
          tiles[t].update_attributes(tile_set_order: t - 1)
        end
      elsif @position < @tile.tile_set_order
        (@position..@tile.tile_set_order - 1).each do |t|
          tiles[t].update_attributes(tile_set_order: t + 1)
        end
      end
      
      @tile.update_attributes(tile_set_order: @position)  
    elsif @tile.tile_set_id #&& @tile_set.instance_of? TileSet
      #moving from one tile set to another
      from = TileSet.find(@tile.tile_set_id)
      from_tiles = @from.tiles.order(:tile_set_order)
      (@tile.tile_set_order + 1..from_tiles.length - 1).each do |t|
        from_tiles[t].update_attributes(tile_set_order: t - 1)
      end

      tiles = @tile_set.tiles.order(:tile_set_order)
      (@position..tiles.length - 1).each do |t|
        tiles[t].update_attributes(tile_set_order: t + 1)
      end

      @tile.update_attributes(tile_set_id: @tile_set.id, tile_set_order: @position)
    else
      raise("invalid use of moveTile")
    end  
  end
end