require_relative './market'
require_relative './population'
require_relative './climate'
require_relative './day'
require_relative './inventory'
require_relative './lemonade_maker'
require_relative './bussiness'
require_relative './user_interface'

class LemonadeStand
  def run
    day = Day.new(Climate.new(previous_temp: rand(0..30)), Population.new, Market.new)
    inventory = Inventory.new(cash: 200)
    bussiness = Bussiness.new(day, inventory, LemonadeMaker.new(inventory))
    user_interface = UserInterface.new

    user_interface.start_game

    20.times do 
      if bussiness.bankrupt? 
        break
      end

      bussiness.start_day
      user_interface.start_day(day.temp, day.price_of_lemons, day.price_of_sugar, inventory.money, inventory.items)

      amount_lemons = user_interface.get_number_of_lemons_to_buy(bussiness.max_possible_lemons_you_can_afford)
      bussiness.buy_lemons(amount_lemons)
      amount_sugar = user_interface.get_number_of_sugar_to_buy(bussiness.max_possible_sugar_you_can_afford)
      bussiness.buy_sugar(amount_sugar)

      amount_lemonade = user_interface.get_number_of_cups_to_make(bussiness.max_possible_lemonade_to_make)
      bussiness.make_lemonade(amount_lemonade)

      price_of_lemonade = user_interface.get_price_of_lemonade
      bussiness.set_price_of_lemonade(price_of_lemonade)

      profit = bussiness.end_day
      user_interface.end_day(profit)
    end
  end
end

# lemonade_stand = LemonadeStand.new
# lemonade_stand.run