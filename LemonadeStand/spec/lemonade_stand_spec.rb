require_relative '../lib/lemonade_stand'

RSpec.describe LemonadeStand do
  let(:bussiness) {instance_double('Bussiness',start_day: 0,max_possible_lemonade_to_make: 1,max_possible_lemons_you_can_afford: 1, max_possible_sugar_you_can_afford: 1,set_price_of_lemonade: 4,buy_lemons: 0,buy_sugar: 0,make_lemonade: 0, end_day: 0,bankrupt?: false)}
  let(:day) {instance_double('Day',temp: 30, price_of_sugar: 3, price_of_lemons: 30)}
  let(:inventory) {instance_double('Inventory', money: 20, items: {:lemons => 1, :sugar => 1})}
  let(:user_interface) {instance_double('UserInterface',start_game: 1, start_day: 0, get_number_of_lemons_to_buy: 1, get_number_of_sugar_to_buy: 1, get_number_of_cups_to_make: 1, get_price_of_lemonade: 4, end_day: 0)}
  let(:lemonade_stand) {LemonadeStand.new}

  before do
    allow(LemonadeStand::UserInterface).to receive(:new).and_return(user_interface)
    allow(LemonadeStand::Bussiness).to receive(:new).and_return(bussiness)
    allow(LemonadeStand::Day).to receive(:new).and_return(day)
    allow(LemonadeStand::Inventory).to receive(:new).and_return(inventory)
  end
  
  it "calls start_game on user_interface" do
    expect(user_interface).to receive(:start_game).once

    lemonade_stand.run
  end

  it "calls bankrupt on bussiness 20 times" do
    expect(bussiness).to receive(:bankrupt?).exactly(20).times

    lemonade_stand.run
  end

  it "calls start_day on bussiness" do
    expect(bussiness).to receive(:start_day).exactly(20).times

    lemonade_stand.run
  end

  it "calls start_day on user_interface" do
    expect(user_interface).to receive(:start_day).with(day.temp,day.price_of_lemons,day.price_of_sugar,inventory.money, inventory.items).exactly(20).times

    lemonade_stand.run
  end

  it "calls get_number_of_lemons_to_buy on user_interface" do
    expect(bussiness).to receive(:max_possible_lemons_you_can_afford).and_return 1
    expect(user_interface).to receive(:get_number_of_lemons_to_buy).with(1).exactly(20).times

    lemonade_stand.run
  end

  it "calls buy_lemons on bussiness" do
    expect(bussiness).to receive(:buy_lemons).exactly(20).times

    lemonade_stand.run
  end

  it "calls get_number_of_sugar_to_buy on user_interface" do
    expect(bussiness).to receive(:max_possible_sugar_you_can_afford).and_return 1
    expect(user_interface).to receive(:get_number_of_sugar_to_buy).with(1).exactly(20).times

    lemonade_stand.run
  end

  it "calls buy_sugar on bussiness" do
    expect(bussiness).to receive(:buy_sugar).exactly(20).times

    lemonade_stand.run
  end

  it "calls get_number_of_cups_to_make on user_interface" do
    expect(user_interface).to receive(:get_number_of_cups_to_make).with(bussiness.max_possible_lemonade_to_make).exactly(20).times

    lemonade_stand.run
  end

  it "calls make_lemonade on bussiness" do
    expect(bussiness).to receive(:make_lemonade).exactly(20).times

    lemonade_stand.run
  end

  it "calls get_price_of_lemonade on bussiness" do
    expect(user_interface).to receive(:get_price_of_lemonade).exactly(20).times
    expect(bussiness).to receive(:set_price_of_lemonade).with(4).exactly(20).times

    lemonade_stand.run
  end

  it "calls end_day on bussiness" do
    expect(bussiness).to receive(:end_day).exactly(20).times

    lemonade_stand.run
  end

  it "calls end_day on user_interface" do
    expect(user_interface).to receive(:end_day).exactly(20).times

    lemonade_stand.run
  end
end