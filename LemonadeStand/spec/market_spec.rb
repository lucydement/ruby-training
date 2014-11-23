require_relative '../lib/market'

RSpec.describe Market do
  let(:market) {Market.new}

  context "price of a lemon" do
    it "generates a random price between 25 and 50" do
      expect(market).to receive(:rand).with(25..50).and_return(30)

      expect(market.price_of_a_lemon).to eq 30
    end
  end

  context "price of sugar" do
    it "generates a random price between 2 and 5" do
      expect(market).to receive(:rand).with(2..5).and_return(4)

      expect(market.price_of_sugar).to eq 4
    end
  end
end