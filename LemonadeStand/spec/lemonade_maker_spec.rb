require_relative '../lib/lemonade_maker'

RSpec.describe LemonadeMaker do
    let(:inventory) {instance_double('Inventory',items: {:lemons => 3, :sugar => 2, :lemonade => 2})}
    let(:lemonade_maker) {LemonadeMaker.new(inventory)}

  context "When there aren't enough lemons" do
    it "will return nil" do
      expect(lemonade_maker.make_lemonade(4)).to be_nil
    end
  end

  context "When there isn't enough sugar" do
    it "will return nil" do
      expect(lemonade_maker.make_lemonade(4)).to be_nil
    end
  end

  context "When selling lemonade" do
    it "will sell all lemonade when more people buy than there is lemonade" do
      expect(inventory).to receive(:sell_lemonade).with(2, 3).once

      lemonade_maker.sell_lemonade(3,3)
    end

    it "will sell lemonade for all people walking by when there is more lemonade than people" do
      expect(inventory).to receive(:sell_lemonade).with(1,3).once

      lemonade_maker.sell_lemonade(1,3)
    end
  end

  it "Finds the max possible lemonade that can be made" do
    expect(lemonade_maker.max_possible_lemonade_to_make).to eql 2 
  end
end