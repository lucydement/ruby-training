class LemonadeMaker
  RECIPE_LEMONS = 1
  RECIPE_SUGAR = 1

  def initialize(inventory)
    @inventory = inventory
  end

  def make_lemonade(amount)
    if amount * RECIPE_LEMONS <= @inventory.items[:lemons] && amount * RECIPE_SUGAR <= @inventory.items[:sugar]
      @inventory.make_lemonade(amount, RECIPE_LEMONS, RECIPE_SUGAR)
    end
  end

  def sell_lemonade(amount_of_people, price)
    if @inventory.items[:lemonade] < amount_of_people
      @inventory.sell_lemonade(@inventory.items[:lemonade], price)
    else
      @inventory.sell_lemonade(amount_of_people, price)
    end
  end

  def max_possible_lemonade_to_make
    [@inventory.items[:lemons] / RECIPE_LEMONS, @inventory.items[:sugar] / RECIPE_SUGAR].min.to_i
  end
end