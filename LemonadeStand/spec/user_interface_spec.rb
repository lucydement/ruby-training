require_relative '../lib/user_interface'

RSpec.describe UserInterface do
  let(:user_interface) {UserInterface.new}

  context "When buying lemons" do
    it "should return a non nil thing" do
      expect(user_interface).to receive(:gets).and_return("1")

      expect(user_interface.get_number_of_lemons_to_buy(2)).to_not be_nil
    end

    it "should loop untill it has valid input" do
      expect(user_interface).to receive(:gets).and_return("-1","3","1")

      expect(user_interface.get_number_of_lemons_to_buy(2)).to eql 1
    end
  end

  context "When buying sugar" do
    it "should return a non nil thing" do
      expect(user_interface).to receive(:gets).and_return("1")

      expect(user_interface.get_number_of_sugar_to_buy(2)).to_not be_nil
    end

    it "should loop untill it has valid input" do
      expect(user_interface).to receive(:gets).and_return("-1","3","1")

      expect(user_interface.get_number_of_sugar_to_buy(2)).to eql 1
    end
  end

  context "When making lemonade" do
    it "should loop untill it has valid input" do
      expect(user_interface).to receive(:gets).and_return("-1","3","1")

      expect(user_interface.get_number_of_sugar_to_buy(2)).to eql 1
    end
  end

  context "When seting the price of lemonade" do
    it "will return a number" do
      expect(user_interface).to receive(:gets).and_return("1")

      expect(user_interface.get_price_of_lemonade).to eql 1
    end
  end
end