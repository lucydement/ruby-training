require_relative '../lib/inventory'

RSpec.describe Inventory do
  let(:inventory) {Inventory.new(cash: 60)}

  context "When making one cup of lemonade" do
    it "has one less lemon" do
      expect {inventory.make_lemonade(1,1,1)}.to change{inventory.items[:lemons]}.by -1
    end

    it "has one less sugar" do
      expect {inventory.make_lemonade(1,1,1)}.to change{inventory.items[:sugar]}.by -1
    end

    it "has one more lemonade" do
      expect {inventory.make_lemonade(1,1,1)}.to change{inventory.items[:lemonade]}.by 1
    end
  end

  context "When making two cups of lemonade" do
    it "has two less lemons" do
      expect {inventory.make_lemonade(2,1,1)}.to change{inventory.items[:lemons]}.by -2
    end

    it "has two less sugar" do
      expect {inventory.make_lemonade(2,1,1)}.to change{inventory.items[:sugar]}.by -2
    end

    it "has two more cups of lemonade" do
      expect {inventory.make_lemonade(2,1,1)}.to change{inventory.items[:lemonade]}.by 2
    end
  end

  context "When buying lemons" do
    it "has one more lemon" do
      expect {inventory.buy(:lemons, price: 30, number: 1)}.to change{inventory.items[:lemons]}.by 1
    end

    it "has two more lemons" do
      expect {inventory.buy(:lemons, price: 30, number: 2)}.to change{inventory.items[:lemons]}.by 2
    end

    it "has one lemon worth of money less" do
      expect {inventory.buy(:lemons, price: 30, number: 1)}.to change{inventory.money}.by -30
    end

    it "has two lemons less of money" do
      expect {inventory.buy(:lemons, price: 30, number: 2)}.to change{inventory.money}.by -60
    end
  end

  context "When buying sugar" do
    it "has one more sugar" do
      expect {inventory.buy(:sugar, price: 3, number: 1)}.to change{inventory.items[:sugar]}.by 1
    end

    it "has two more sugar" do
      expect {inventory.buy(:sugar, price: 3, number: 2)}.to change{inventory.items[:sugar]}.by 2
    end

    it "has one sugar worth of money less" do
      expect {inventory.buy(:sugar, price: 3, number: 1)}.to change{inventory.money}.by -3
    end

    it "has two sugars worth of money less" do
      expect {inventory.buy(:sugar, price: 3, number: 2)}.to change{inventory.money}.by -6
    end
  end

  context "When you don't have enough money" do
    context "When buying lemons" do
      it "doesn't change the amount of lemons" do
        expect {inventory.buy(:lemons, price: 30, number: 3)}.to_not change{inventory.items[:lemons]}
      end

      it "doesn't change the amount of money" do
        expect {inventory.buy(:lemons, price: 30, number: 3)}.to_not change{inventory.money}
      end
    end

    context "When buying sugar" do
      it "doesn't change the amount of sugar" do
        expect {inventory.buy(:sugar, price: 3, number: 31)}.to_not change{inventory.items[:sugar]}
      end

      it "doesn't change the amount of money" do
        expect {inventory.buy(:sugar, price: 3, number: 31)}.to_not change{inventory.money}
      end
    end
  end

  context "When reseting lemonade" do
    before do
      inventory.make_lemonade(1,1,1)
    end

    it "will have no lemonade" do
      expect {inventory.reset_lemonade}.to change {inventory.items[:lemonade]}.by -1
    end
  end

  context "When selling lemonade" do
    it "decreases the amount of lemonade" do
      expect {inventory.sell_lemonade(1,2)}.to change {inventory.items[:lemonade]}.by -1
    end

    it "increases the amount of money" do
      expect {inventory.sell_lemonade(1,2)}.to change {inventory.money}.by 2
    end
  end
end