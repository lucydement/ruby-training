MAX_QUALITY = 50
MIN_QUALITY = 0

def update_quality(items)
  items.each do |item|
    case
    when item.name == "Aged Brie"
      update_aged_brie(item)
    when item.name == "Backstage passes to a TAFKAL80ETC concert"
      update_concert_tickets(item)
    when item.name == "Sulfuras, Hand of Ragnaros"
      update_sulfuras(item)
    else
      update_normal_item(item)
    end
  end
end

private

def update_normal_item(item)
  item.sell_in -= 1
  if item.sell_in < 0
    quality_minus(item, 2)
  else
    quality_minus(item, 1)
  end
end

def update_sulfuras(item)
end

def update_aged_brie(item)
  item.sell_in -= 1
  if item.sell_in < 0
    quality_add(item, 2)
  else
    quality_add(item, 1)
  end
end

def update_concert_tickets(item)
  item.sell_in -= 1

  case
  when item.sell_in >= 10
    quality_add(item, 1)
  when item.sell_in >= 5
    quality_add(item, 2)
  when item.sell_in >= 0
    quality_add(item, 3)
  else
    item.quality = MIN_QUALITY
  end
end

def quality_minus(item, amount)
  if item.quality - amount < MIN_QUALITY
    item.quality = MIN_QUALITY
  else
    item.quality = item.quality - amount
  end
end

def quality_add(item, amount)
  if item.quality + amount > MAX_QUALITY
    item.quality = MAX_QUALITY
  else
    item.quality = item.quality + amount
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

