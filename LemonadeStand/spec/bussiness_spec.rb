require_relative '../lib/bussiness'

RSpec.describe Bussiness do
  let(:day) {instance_double('Day',price_of_sugar: 3, generate_new_day: 1, price_of_lemons: 30,number_of_people_walking_by: 1, temp: 30)}
  let(:inventory) {instance_double('Inventory',items: {:lemons =>3, :sugar => 3}, money: 59, reset_lemonade: 0, buy: 1)}
  let(:lemonade_maker) {instance_double('LemonadeMaker', sell_lemonade: 1)}
  let(:people_buying) {instance_double('PeopleBuying',calculate: 1)}
  let(:bussiness) {Bussiness.new(day, inventory, lemonade_maker)}

  before do
    allow(PeopleBuying).to receive(:new).and_return people_buying
  end

  context "When starting a new day" do
    it "calls generate_new_day" do
      expect(day).to receive(:generate_new_day).once

      bussiness.start_day
    end
  end

  it "finds the max possible lemons possible to buy" do
    expect(bussiness.max_possible_lemons_you_can_afford).to eql 1
  end

  context "When buying lemons" do
    it "calls buy_lemons on inventory" do
      expect(inventory).to receive(:buy).with(:lemons,price: 30,number: 2).once

      bussiness.buy_lemons(2)
    end
  end

  it "finds the max possible amount of sugar you can buy" do
    expect(bussiness.max_possible_sugar_you_can_afford).to eql 19
  end

  context "When buying sugar" do
    it "calls buy_sugar on inventory" do
      expect(inventory).to receive(:buy).with(:sugar, price: 3, number: 3).once

      bussiness.buy_sugar(3)
    end
  end

  context "When seting the price of lemonade" do
    it "Sets the price of lemonade" do
      expect(bussiness.set_price_of_lemonade(2)).to eql 2
    end
  end

  context "When a day ends" do
    it "calls number_of_people_buying on day" do
      expect(day).to receive(:number_of_people_walking_by).once

      bussiness.end_day
    end

    it "calls sell_lemonade on lemonade_maker" do
      bussiness.set_price_of_lemonade(3)
      expect(lemonade_maker).to receive(:sell_lemonade).with(day.number_of_people_walking_by,3).once

      bussiness.end_day
    end

    it "calls reset_lemonade on inventory" do
      expect(inventory).to receive(:reset_lemonade).once

      bussiness.end_day
    end
  end

  context "When bankrupt" do
    it "should return true when there are no lemons and not enough money to buy a lemon" do
      var = {:lemons => 0, :sugar => 3}
      expect(inventory).to receive(:items).and_return var
      expect(inventory).to receive(:money).and_return 24

      expect(bussiness.bankrupt?).to be true
    end

    it "should return true when there are no sugar and not enough money to buy sugar" do
      var = {:lemons => 3, :sugar => 0}
      expect(inventory).to receive(:items).twice.and_return var
      expect(inventory).to receive(:money).and_return 1

      expect(bussiness.bankrupt?).to be true
    end
  end

  context "When not bankrupt" do
    it "should return false when there are lemons and sugar but no money" do
      allow(inventory).to receive(:money).and_return 0

      expect(bussiness.bankrupt?).to be false
    end
  end
end