class Game < ActiveRecord::Base
  has_many :tiles
  has_many :players

  def bag
    tiles.where(player_id: nil, on_board: nil)
  end

  def won?
    players.each do |player|
      if player.tiles.length == 0
        return player.number
      end
    end
    return false
  end

  def ended?
    return true if won?
    if bag.empty? 
      players.each do |player|
        return false if !player.passed
      end
      return true
    end
    false
  end

  def setup
    (1..13).each do |t|
      tiles.create(colour: "red", number: t) 
      tiles.create(colour: "red", number: t)
      tiles.create(colour: "blue", number: t)
      tiles.create(colour: "blue", number: t)
      tiles.create(colour: "black", number: t)
      tiles.create(colour: "black", number: t)
      tiles.create(colour: "yellow", number: t)
      tiles.create(colour: "yellow", number: t) 
    end

    (0..3).each do |i|
      player = players.create(number: i)
      (1..14).each do
        tile = bag.sample
        tile.update_attributes!(player_id: player.id)
      end
    end

    update_attributes!(current_player: 0)
  end
end