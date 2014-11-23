require_relative './people_buying'

class Bussiness
  def initialize(day, inventory, lemonade_maker)
    @day = day
    @inventory = inventory
    @lemonade_maker = lemonade_maker
    @people_buying = PeopleBuying.new
  end

  def start_day
    @day.generate_new_day
  end

  def max_possible_lemons_you_can_afford
    (@inventory.money / @day.price_of_lemons).to_i
  end

  def buy_lemons(amount)
    @inventory.buy(:lemons, price: @day.price_of_lemons,number: amount)
  end

  def max_possible_sugar_you_can_afford
    (@inventory.money / @day.price_of_sugar).to_i
  end

  def buy_sugar(amount)
    @inventory.buy(:sugar, price: @day.price_of_sugar,number: amount)
  end

  def make_lemonade(amount)
    @lemonade_maker.make_lemonade(amount)
  end

  def max_possible_lemonade_to_make
    @lemonade_maker.max_possible_lemonade_to_make
  end

  def set_price_of_lemonade(price)
    @price_of_lemonade = price
  end

  def end_day
    people_buying = @people_buying.calculate(@day.number_of_people_walking_by, @price_of_lemonade)
    profit = @lemonade_maker.sell_lemonade(people_buying, @price_of_lemonade)
    @inventory.reset_lemonade
    profit
  end

  def bankrupt?
    if @inventory.items[:lemons] < LemonadeMaker::RECIPE_LEMONS && @inventory.money < 25 * LemonadeMaker::RECIPE_LEMONS
      return true
    end
    if @inventory.items[:sugar] < LemonadeMaker::RECIPE_SUGAR && @inventory.money < 2 * LemonadeMaker::RECIPE_SUGAR
      return true
    end
    false
  end
end