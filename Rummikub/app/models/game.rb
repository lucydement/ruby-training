class Game < ActiveRecord::Base
  NUMBER_PLAYERS = 4
  BOARD_WIDTH = 15
  BOARD_HEIGHT = 7

  has_many :tiles
  has_many :players 

  def bag
    tiles.where(player_id: nil, on_board: nil)
  end

  def won?
    if player = players.detect {|player| player.tiles.empty?}
      player.number
    end
  end

  def ended?
    return true if won?
    return false if !bag.empty? 
    return false if players.detect {|player| !player.passed}
    true
  end
end