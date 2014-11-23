require_relative '../lib/day'

RSpec.describe Day do
  let(:climate) {instance_double('Climate', generate_temp: 30)}
  let(:market) {instance_double('Market', price_of_sugar: 3, price_of_a_lemon: 30)}
  let(:population) {instance_double('Population', number_of_people_walking_by:6)}
  let(:day) {Day.new(climate, population, market)}

  context "When generating a new day" do
    it "generates a new temperature" do
      expect(climate).to receive(:generate_temp).once

      day.generate_new_day
    end

    it "generates the price of sugar" do
      expect(market).to receive(:price_of_sugar).once

      day.generate_new_day
    end

    it "generates the price of lemons" do
      expect(market).to receive(:price_of_a_lemon).once

      day.generate_new_day
    end

    it "generates the number of people buying lemonade" do
      expect(population).to receive(:number_of_people_walking_by).with(temp: climate.generate_temp).once

      day.generate_new_day
    end
  end
end

