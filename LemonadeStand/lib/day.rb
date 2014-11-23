class Day
  attr_reader :temp
  attr_reader :price_of_sugar
  attr_reader :price_of_lemons
  attr_reader :number_of_people_walking_by

  def initialize(climate, population, market)
    @climate = climate
    @population = population
    @market = market
  end

  def generate_new_day
    @temp = @climate.generate_temp
    @price_of_sugar = @market.price_of_sugar
    @price_of_lemons = @market.price_of_a_lemon
    @number_of_people_walking_by = @population.number_of_people_walking_by(temp: @temp)
  end
end