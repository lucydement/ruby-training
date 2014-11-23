class Inventory 
  attr_reader :items
  attr_reader :money

  def initialize(cash:)
    @items = {
      :lemons => 0,
      :sugar => 0,
      :lemonade => 0
    }
    @money = cash
  end

  def reset_lemonade
    @items[:lemonade] = 0
  end

  def make_lemonade(amount, lemons_used, sugar_used)
    @items[:lemons] -= lemons_used * amount
    @items[:sugar] -= sugar_used * amount
    @items[:lemonade] += amount
  end

  def sell_lemonade(amount, price)
    @items[:lemonade] -= amount
    @money += amount * price
    amount * price
  end

  def buy(item, price:, number:)
    if money >= price * number && item != :lemonade
      @items[item] += number
      @money -= price * number
    end
  end
end